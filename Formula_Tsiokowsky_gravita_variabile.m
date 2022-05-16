close all; clc; clear;
% Questo programma calcola il delta v necessario a un razzo e la m2 del
% secondo stadio
% Approssimazioni fatte:
% Resistenza dell'aria da una vd = 0.1% per il primo stadio e 0.05% per il
% secondo stadio (PA quando hai la traiettoria effettiva, dopo 100km non
% vale più la resistenza dell'aria)
% Considero la V effettiva pari alla v del razzo e la calcolo con go
% Considero che il razzo non acceleri ma che ogni stadio vada alla sua ve
% Tempo fra spegnimento di un motore e accensione del successivo:
% ts = 0 perché si accendono prima del distacco
% suppongo che lo stadio 3 e 4 mettano il satellite in orbita
% 1. g = variabile con la quota
% 1. g non considerata nel 2,3,4 stadio
% 1. razzo in verticale
% 1. g è considerata all'accensione di ogni stadio
% 2. razzo con un angolo di 82°

% Il calcolo può essere fatto tenendo conto di due tipi di missioni: LEO e
% GTO entrambe fatte con quarto stadio Briz


% Il razzo vola in verticale
% Non considero la resistenza dell'aria perché non abbiamo i dati necessari
% a considerarla, sarebbe un'implementazione troppo complicata
% Considero l'accelerazion del razzo circa constante (approssimazione
% valida fino a LEO
% Ogni motore si accende appena prima del distacco
% info dal sito
% http://spaceacademy.net.au/flight/spfl/rocksci.htm
% http://www.astronautix.com/p/proton-k17s40.html

go = 9.81;
ts = 0;
Ro = 6378388; % raggio della Terra in metri
vd1 = 0.1; % percentuale di velocità che viene eliminata con la Drag
vd2 = 0.05;
%% Dati UDMH

% Mpay = massa payload
% Msu_i = massa della struttura dello stadio i dell'orignale
% Mpu_i = massa del propellente dello stadio i dell'originale
% tui = tempo totale di combustione dello stadio i
% Isp_ui = Impulso specifico stadio i
% ue_i = velocità efficacie dello stadio i 

%% DATI DA CAMBIARE QUARTO STADIO
%Mpay = 6900; %GTO
Mpay = 20000; %LEO

%Britz
Msu_4 = 2390;
Mpu_4 = 19820;
tu4 = 3200;
Isp_u4 = 328;
ue_4 = Isp_u4 * go;

%Block

%% DATI ALTRI STADI
Msu_3 = 4185;
Mpu_3 = 46562;
tu3 = 234;
Msu_2 = 11400;
Mpu_2 = 157300;
tu2 = 213.3;
Msu_1 = 30600;
Mpu_1 = 6.457345588576308e+04 * 6;
tu1 = 119.7;

Isp_u1 = 2890.2/go;
Isp_u2 = 327;
Isp_u3 = 325;

ue_1 = Isp_u1 * go; %m/s
ue_2 = Isp_u2 * go;
ue_3 = Isp_u3 * go;

%% calcolo delle altezze e g di ogni stadio:
h1f = ue_1 * tu1;
h2i = h1f;
h2f = h2i + ue_2 * tu2; 
h3i = h2f;
h3f = h3i + ue_3 * tu3; 
h4i = h3f; 
h4f = h4i + ue_4 * tu4; 
h4orbita = 400000;
h3orbita = 200000; 

gu2 = go * (Ro / (Ro + h2i))^2;
gu3 = go * (Ro / (Ro + h3orbita))^2;
gu4 = go * (Ro / (Ro + h4orbita))^2;
%% Calcolo delta v UDMH approssimazione 1
% mi_ui = massa iniziale dello stadio i 
% mf_ui = massa finale dello stadio i
% dd_1 = v percentuale di drag
mi_u4 = Msu_4 + Mpay + Mpu_4; 
mf_u4 = Msu_4 + Mpay;
mi_u3 = Msu_3 + mi_u4 + Mpu_3; 
mf_u3 = Msu_3 + mi_u4;
mi_u2 = Msu_2 + mi_u3 + Mpu_2; 
mf_u2 = Msu_2 + mi_u3;
mi_u1 = Msu_1 + mi_u2 + Mpu_1; 
mf_u1 = Msu_1 + mi_u2;
%vdu = sqrt(2*Fd/(Ae*Cd*rho_a));

du_1 = ue_1 * log(mi_u1/mf_u1) - go * tu1;
ddu_1 = vd2 * ue_1 * log(mi_u1/mf_u1);
du_1 = du_1-ddu_1;
%du_2 = ue_2 * log(mi_u2/mf_u2);
du_2 = ue_2 * log(mi_u2/mf_u2) - gu2 * tu2;
ddu_2 = vd2 * ue_2 * log(mi_u2/mf_u2);
%du_2 = du_2-ddu_2;
%du_3 = ue_3 * log(mi_u3/mf_u3);
du_3 = ue_3 * log(mi_u3/mf_u3) - gu3 * tu3;
du_4 = ue_4 * log(mi_u4/mf_u4);
%du_4 = ue_4 * log(mi_u4/mf_u4) - gu4 * tu4;

du_t = du_1 + du_2 + du_3 + du_4 - go * ts - ddu_1 - ddu_2;

%% Dati RP-1
% Calcolo delle caratteristiche con secondo stadio invariato per avere un
% paragone sensato
Ms_1 = 30600;
Mp_1 = 6.4132e+04 * 6;
t1 = 96.5237;

Isp_1 = 296.6463;
ve_1 = Isp_1 * go; 

mi_1 = Ms_1 + mi_u2 + Mp_1; 
mf_1 = Ms_1 + mi_u2;
Tr = 1.7141e+06 * 6;
mpunto_p = 632.7768*6;

dv_1 = ve_1 * log(mi_1/mf_1)- go * t1;
dd_1 = dv_1 * vd2;
dv_t = dv_1 + du_2 + du_3 + du_4 - go * ts - dd_1;

%% calcolo massa Mf2
% impongo dv_t = du_t
% calcolo della massa di propellente in stadio 2 per non avere sovra
% dimensionamento
% Nel caso in cui consideriamo la gravità nel secondo stadio, uso le
% formule che contegono g e mi permettono di calcolare la mf e tb
% Posso anche calcolare ue che dovrei avere lasciando massa di propellente
% e tempo invariato. Comunque non posso agire su questa perché è
% determinata da Isp

% PA: se considero la gravità nel secondo stadio devo considerare la
% relazione fra tb, Isp e Mtot fuel per poter calcolare il tempo e la massa
% non sovradimensionati

Dv2 = du_t - dv_1 - du_3 - du_4 + dd_1 + ddu_2;
%MI2 = mf_u2 * exp((Dv2)/ue_2);
%Ue2 = Dv2/(log(mi_u2/mf_u2));
MI2 = mf_u2 * exp((Dv2 + gu2*tu2)/ue_2);
t2 = (ue_2 * log(mi_u2/mf_u2)-Dv2)/gu2;
Ue2 = (Dv2 + gu2*tu2)/(log(mi_u2/mf_u2));
Mp_2 = MI2 - mf_u2

Deltav = du_2 - Dv2
Deltamf = Mpu_2 - Mp_2