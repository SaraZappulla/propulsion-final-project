close all; clc; clear;
% Questo programma calcola il delta v necessario a un razzo e la m2 del
% secondo stadio
% Approssimazioni fatte:
% Resistenza dell'aria = 0
% Tempo fra spegnimento di un motore e accensione del successivo:
% ts = 0 perché si accendono prima del distacco
% 1. g = cost
% 1. g non considerata nel 2,3,4 stadio
% 2. commentato nel programma di default: 
% 2. g considerata anche in 2,3,4 stadii

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
%% Dati UDMH

% Mpay = massa payload
% Msu_i = massa della struttura dello stadio i dell'orignale
% Mpu_i = massa del propellente dello stadio i dell'originale
% tui = tempo totale di combustione dello stadio i
% Isp_ui = Impulso specifico stadio i
% ue_i = velocità effettiva dello stadio i 

%% DATI DA CAMBIARE QUARTO STADIO


%Britz
%Mpay = 6900; %GTO
Mpay = 20000; %LEO
Msu_4 = 2390;
Mpu_4 = 19820;

%Block
%Msu_4 = 3420;
%Mpu_4 = 15050;
%Mpay = 2600; %GTO
    
%% DATI ALTRI STADI
Msu_3 = 4185;
Mpu_3 = 46562;
Msu_2 = 11400;
Mpu_2 = 157300;
tu2 = 213.3;
Msu_1 = 30600;
Mpu_1 = 6.457345588576308e+04 * 6;
tu1 = 119.7;

Isp_u1 = 2890.2/go;
Isp_u2 = 327;

ue_1 = Isp_u1 * go; %m/s
ue_2 = Isp_u2 * go;

% DATI per funzione
T_u =1.649783376099530e+06 * 6;
%% Calcolo delta v UDMH approssimazione 1
% mi_ui = massa iniziale dello stadio i 
% mf_ui = massa finale dello stadio i
mi_u4 = Msu_4 + Mpay + Mpu_4; 
mf_u4 = Msu_4 + Mpay;
mi_u3 = Msu_3 + mi_u4 + Mpu_3; 
mf_u3 = Msu_3 + mi_u4;
mi_u2 = Msu_2 + mi_u3 + Mpu_2; 
mf_u2 = Msu_2 + mi_u3;
mi_u1 = Msu_1 + mi_u2 + Mpu_1; 
mf_u1 = Msu_1 + mi_u2;

du_1 = ue_1 * log(mi_u1/mf_u1) - go * tu1;
du_2 = ue_2 * log(mi_u2/mf_u2);
%du_2 = ue_2 * log(mi_u2/mf_u2) - g * tu2;

du_t = du_1 + du_2 - go * ts;

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

dv_1 = ve_1 * log(mi_1/mf_1)- go * t1;
dv_t = dv_1 + du_2 - go * ts;

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

Dv2 = du_t - dv_1;
MI2 = mf_u2 * exp((Dv2)/ue_2);
Ue2 = Dv2/(log(mi_u2/mf_u2));
%MI2 = mf_u2 * exp((Dv2 + g*tu2)/ue_2);
%t2 = (ue_2 * log(mi_u2/mf_u2)-Dv2)/g;
%Ue2 = (Dv2 + gu2*tu2)/(log(mi_u2/mf_u2));
Mp_2 = MI2 - mf_u2

Deltav = dv_t - du_t
Deltamf = Mpu_2 - Mp_2
