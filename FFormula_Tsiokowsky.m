close all; clc; clear;
% Questo programma calcola il delta v necessario a un razzo e la m2 del
% secondo stadio
% Approssimazioni fatte:
% Resistenza dell'aria = 0
% Forza di gravità non tenuta in conto

% Il calcolo può essere fatto tenendo conto di due tipi di missioni: LEO e
% GTO entrambe fatte con quarto stadio Briz

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
% ue_i = velocità efficacie dello stadio i 

%Mpay = 6900; %GTO
Mpay = 20000; %LEO
%Britz
Msu_4 = 2390;
Mpu_4 = 19820;
tu4 = 3200;
Isp_u4 = 328;
ue_4 = Isp_u4 * go;

%Block


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

ue_1 = Isp_u1 * go;
ue_2 = Isp_u2 * go;
ue_3 = Isp_u3 * go;
ue_4 = Isp_u4 * go;
%% Calcolo delta v UDMH
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

du_1 = ue_1 * log(mi_u1/mf_u1);
du_2 = ue_2 * log(mi_u2/mf_u2);
du_3 = ue_3 * log(mi_u3/mf_u3);
du_4 = ue_4 * log(mi_u4/mf_u4);

du_t = du_1 + du_2 + du_3 + du_4;

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

dv_1 = ve_1 * log(mi_1/mf_1);
dv_t = dv_1 + du_2 + du_3 + du_4;

%% calcolo massa Mf2
% impongo dv_t = du_t
% calcolo della massa di propellente in stadio 2 per non avere sovra
% dimensionamento

Dv2 = du_t - dv_1 - du_3 - du_4;
MI2 = mf_u2 * exp(Dv2/ue_2);
Mp_2 = MI2 - mf_u2

Deltav = du_2 - Dv2
Deltamf = Mpu_2 - Mp_2

