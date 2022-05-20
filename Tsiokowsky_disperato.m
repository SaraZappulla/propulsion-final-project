close all; clc; clear;
% Questo programma calcola il deltaV del primo stadio del razzo UDMH 
% originario, lo uguaglia al primo stadio modificato e calcola di
% conseguenza i parametri necessari, come Mtot di propellente da caricare,
% Vtot e tb per completare la missione

% Il calcolo può essere fatto tenendo conto di due tipi di missioni: LEO e
% GTO entrambe fatte con quarto stadio Briz o con il Block

go = 9.81;
ts = 0;
Ro = 6378388; % raggio della Terra in metri
rhoo = 1.225;
%% Dati UDMH

% Mpay = massa payload
% Msu_i = massa della struttura dello stadio i dell'orignale
% Mpu_i = massa del propellente dello stadio i dell'originale
% tui = tempo totale di combustione dello stadio i
% Isp_ui = Impulso specifico stadio i
% ue_i = velocità efficacie dello stadio i 

%% DATI DA CAMBIARE QUARTO STADIO

%Britz
%Mpay = 6900; %GTO
Mpay = 20000; %LEO

Msu_4 = 2390;
Mpu_4 = 19800;

D4 = 4.0;
L4 = 2.65;
T_u4 = 19620;

%Block
%Msu_4 = 3420;
%Mpu_4 = 15050;
%Mpay = 2600;

%% DATI ALTRI STADI
Msu_3 = 4185;
Mpu_3 = 46562;
Msu_2 = 11400;
Mpu_2 = 157300;
Msu_1 = 30600;
Mpu_1 = 6.457345588576308e+04 * 6;
tu1 = 119.7;

Isp_u1 = 2890.2/go;

ue_1 = Isp_u1 * go; %m/s

% DATI per funzione
T_u =1.649783376099530e+06 * 6;
mpunto_p_u = 5.137721755640139e+02 * 6; %kg/s
D1 = 7.4; %m
D2 = 4.1;
D3 = 4.1;
L1 = 21.18;
L2 = 17.5;
L3 = 4.11;

%A1 = D1^2/4 * pi; Area frontale
%A2 = D2^2/4 * pi;
%A3 = D3^2/4 * pi;
%A4 = D4^2/4 * pi;

A1 = pi*D1*L1; %Area laterale
A2 = pi*D2*L2;
A3 = pi*D3*L3;
A4 = pi*D4*L4;
Atot1 = A1 + A2 + A3 + A4;
Atot2 = A2 + A3 + A4;
Atot3 = A3 + A4;

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

%% calcolo delle altezze e g di ogni stadio:
%ricavo l'angolo per la salit acon h circa 42 km
A = [pi/32:0.001:pi/2]
%for i = 1:length(A)
%    [gu1,ddu_1,vf1,hf1,gf1,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,T_u,tu1,0,mi_u1,mpunto_p_u,rhoo,0,go,0,0,A(i));
%    Y(i) = hf1;
%    X(i) = vf1;
%end
%figure(1)
%plot(Y)
%figure(4)
%plot(X)
alpha = A(238);
[gu1,ddu_1,vf1,hf1,gf1,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,T_u,tu1,0,mi_u1,mpunto_p_u,rhoo,0,go,0,0,alpha);


%% Dati RP-1
% Calcolo delle caratteristiche con secondo stadio invariato per avere un
% paragone sensato
Ms_1 = 30600;

Isp_1 = 296.6463;
ve_1 = Isp_1 * go; 

Tr = 1.7141e+06 * 6;
mpunto_p = 632.7768*6;

%Calcolo massa
k = 0.0001 * Mpu_1;
j = 2;
toll = 0.0001 * Mpu_1;
toll2 = 0.01 * ddu_1;
par = 10^5;
ks = 1.05;
Mfuel(1) = 10^3;
i = 1;
while (par >= toll && j<10^5)
    mfuel_o = 10^3 + k * j;
    mi_1 = mfuel_o + mf_u1;
    tb = mfuel_o/((mpunto_p)*ks);

    [g1,dd_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,tb,0,mi_1,mpunto_p,rhoo,0,go,0,0,A(4));
    mscelta2 = 0;
    a = 0;
    if dd_1 < (ddu_1+toll2) && dd_1>(ddu_1-toll2)
        a = 1
        mscelta2 = mfuel_o;
        tbscelto = tb;
    end
    
    if a == 0
   
    else
        i = i+1;
        Mfuel(i) = mscelta2;
        tbr(i) = tbscelto;
        par = abs(Mfuel(i)-Mfuel(i-1))
    end
    j = j + 1
end
figure(7)
plot(Mfuel)
title('Propellant mass iterations')
figure(8)
plot(tbr)
title('Burning time iterations')

dM = Mfuel(end)-Mpu_1

Itot_u = Isp_u1 * Mpu_1;
Itot = Isp_1 * Mfuel(end);
DeltaI = Itot - Itot_u

%% calcolo V
rho_ox = 1450;
rho_f = 810;
OF = 6.9;

mp_ox = OF/(1+OF) .* mpunto_p;
mp_f = 1/(1+OF) .* mpunto_p;

Mtot_r = Mfuel(end)
tb = tbr(end)

Mox = mp_ox .* tb;
Mf = mp_f .* tb;

Vox = Mox./rho_ox;
Vf = Mf./rho_f;
Vtot = Vox + Vf

Vboos = Vtot/6
Mboos = Mtot_r/6