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

%Block
%Msu_4 = 3420;
%Mpu_4 = 15050;
%Mpay = 2600;

%% DATI ALTRI STADI
Msu_3 = 4185;
Mpu_3 = 46562;

Msu_2 = 11400;
Mpu_2 = 157300;
tu2 = 213.3;

Msu_1 = 30600;
Mpu_1 = 6.358322536981013e+04 * 6;
tu1 = 119.7;

Isp_u1 = 3.007237512742100e+02;
Isp_u2 = 327;

ue_1 = Isp_u1 * go; %m/s
ue_2 = Isp_u2 * go;

% DATI per funzione
T_u =1.648141488852405e+06 * 6;
mpunto_p_u = 5.058935065426273e+02 * 6; %kg/s
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

T_u2 = 2400000;

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

%% calcolo delle altezze e g di ogni stadio:
A = [pi/32:0.001:pi/2]
%for i = 1:length(A)
    %[gu1,ddu_1,vf1,hf1,gf1,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,T_u,tu1,0,mi_u1,mpunto_p_u,rhoo,0,go,0,0,A(i));
    %Y(i) = hf1;
    %X(i) = vf1;
%end
%figure(1)
%plot(Y)
%figure(2)
%plot(X)
alpha = A(238);
[gu1,ddu_1,vf1,hf1,gf1,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,T_u,tu1,0,...
    mi_u1,mpunto_p_u,rhoo,0,go,0,0,alpha);
clc
%for i = 1:length(A)
    %[gu2,ddu_2,vf2,hf2,gf2,rhos,hs] = calcolo_dv_drag_gm(vf1,Atot2,T_u2,...
    %tu1+tu2,tu1,mi_u2,Mpu_2/tu2,rhoo,hf1,gf1,rhos,hs,A(i))
    %y(i) = hf2;
%end
%figure (3)
%plot(y)
beta = A(20);
[gu2,ddu_2,vf2,hf2,gf2,rhos,hs] = calcolo_dv_drag_gm(vf1,Atot2,T_u2,tu1+tu2,...
    tu1,mi_u2,Mpu_2/tu2,rhoo,hf1,gf1,rhos,hs,beta);

%% calcolo dv

du_tp = ddu_1 + ddu_2;

%% Dati RP-1
% Calcolo delle caratteristiche con secondo stadio invariato per avere un
% paragone sensato
Ms_1 = 30600;
Mp_1 = 6.4457e+04 * 6;
t1 = 97.0073;

Isp_1 = 296.6463;
ve_1 = Isp_1 * go; 

mi_1 = Ms_1 + mi_u2 + Mp_1; 
mf_1 = Ms_1 + mi_u2;
Tr = 1.7141e+06 * 6;
mpunto_p = 632.81*6;

%Per calcolare l'angolo necessario
%for j = 1:length(A)
    %[g1,dd_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,t1,0,mi_1,mpunto_p,rhoo,0,go,0,0,A(j));
    %y(j) = hf1r;
    %x(j) = vf1r;
%end
%figure (4)
%plot(y)
%figure(5)
%plot(x)
gamma = A(397)
[g1,dd_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,t1,0,mi_1,...
    mpunto_p,rhoo,0,go,0,0,gamma);

%% funzione di risoluzione
[Mp2,deltav2] = calcolo_m2_iterato(Mpay,du_tp,T_u2,Tr,Atot2,Atot1,t1,tu2,...
    mi_u2,mf_u2,Msu_1,Mp_1,mpunto_p,rhoo,beta,gamma);
deltaM = Mpu_2 - Mp2
deltaV = ddu_2 - deltav2
