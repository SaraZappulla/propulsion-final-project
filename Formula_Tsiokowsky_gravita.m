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
% Il razzo vola in verticale

% Il calcolo può essere fatto tenendo conto di due tipi di missioni: LEO e
% GTO entrambe fatte con quarto stadio Briz



% info dal sito
% http://spaceacademy.net.au/flight/spfl/rocksci.htm
% http://www.astronautix.com/p/proton-k17s40.html

g = 9.81;
ts = 0;
%% Dati UDMH

% Mpay = massa payload
% Msu_i = massa della struttura dello stadio i dell'orignale
% Mpu_i = massa del propellente dello stadio i dell'originale
% tui = tempo totale di combustione dello stadio i
% Isp_ui = Impulso specifico stadio i
% ue_i = velocità efficacie dello stadio i 

%Mpay = 6900; %GTO
Mpay = 20000; %LEO
Msu_4 = 2370;
Mpu_4 = 19800;
tu4 = 3000;
Msu_3 = 3500;
Mpu_3 = 46562;
tu3 = 238;
Msu_2 = 11000;
Mpu_2 = 157300;
tu2 = 206;
Msu_1 = 30600;
Mpu_1 = 58282 * 6;
tu1 = 108;

Isp_u1 = 294.6177;
Isp_u2 = 327;
Isp_u3 = 325;
Isp_u4 = 326;

ue_1 = Isp_u1 * g;
ue_2 = Isp_u2 * g;
ue_3 = Isp_u3 * g;
ue_4 = Isp_u4 * g;
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
%vdu = sqrt(2*Fd/(Ae*Cd*rho_a));

du_1 = ue_1 * log(mi_u1/mf_u1) - g * tu1;
du_2 = ue_2 * log(mi_u2/mf_u2);
%du_2 = ue_2 * log(mi_u2/mf_u2) - g * tu2;
du_3 = ue_3 * log(mi_u3/mf_u3);
%du_3 = ue_3 * log(mi_u3/mf_u3) - g * tu3;
du_4 = ue_4 * log(mi_u4/mf_u4);
%du_4 = ue_4 * log(mi_u4/mf_u4) - g * tu4;

du_t = du_1 + du_2 + du_3 + du_4 - g * ts;

%% Dati RP-1
% Calcolo delle caratteristiche con secondo stadio invariato per avere un
% paragone sensato
Ms_1 = 30600;
Mp_1 = 5.7879e+04 * 6;
t1 = 86.7792;

Isp_1 = 296.5647;
ve_1 = Isp_1 * g; 

mi_1 = Ms_1 + mi_u2 + Mp_1; 
mf_1 = Ms_1 + mi_u2;

dv_1 = ve_1 * log(mi_1/mf_1)- g * t1;
dv_t = dv_1 + du_2 + du_3 + du_4 - g * ts;

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

Dv2 = du_t - dv_1 - du_3 - du_4;
MI2 = mf_u2 * exp((Dv2)/ue_2);
Ue2 = Dv2/(log(mi_u2/mf_u2));
%MI2 = mf_u2 * exp((Dv2 + g*tu2)/ue_2);
%t2 = (ue_2 * log(mi_u2/mf_u2)-Dv2)/g;
%Ue2 = Dv2/(log(mi_u2/mf_u2));
Mp_2 = MI2 - mf_u2

Deltav = dv_t - du_t
Deltamf = Mpu_2 - Mp_2
