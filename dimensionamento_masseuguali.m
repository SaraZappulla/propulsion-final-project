close all; clc; clear;
% Programma che contiene considerazioni iniziali, non usato per la
% relazione definitiva, ma solo per i primi ragionamenti: MtotRP1 = MtotUDMMH
% PA valori non aggiornati
%frozen 
Po = 101325;
Ru = 8314;
Mmp = 21.7;
Mmpe = 22.316;
Tc = 3046.32;
OF = 6.9;
gammae = 1.2285;
go = 9.81;
Pc = 16600000; %bar
AeAt = 26.2;
tb = 108;
tbu = 108;
Pe = 59088; %bar
De = 1.431; %m ovvero 0.069 di spessore
Ae = pi * De^2/4;
At = Ae/AeAt;
AcAt = 1.54;
Ac = AcAt*At;
LAMDAe = sqrt(gammae*(2/(gammae+1))^((gammae+1)/(gammae-1)));
ks = 1.05;
%% calcoli di tutto

Isp = 2912.4/go;

Rsig = Ru/Mmpe;
ue_id = sqrt(((2*gammae)/(gammae-1))*Rsig*Tc*(1-(Pe/Pc)^((gammae-1)/gammae)));
mpunto_p = LAMDAe * Pc *At/ (sqrt(Rsig*Tc));
T = mpunto_p * ue_id + (Pe - Po) * Ae;

%% calcolo massa
rho_ox = 1450;
rho_f = 810;

mp_ox = OF/(1+OF) * mpunto_p;
mp_f = 1/(1+OF) * mpunto_p;
Mox = mp_ox * tb * ks;
Mf = mp_f * tb * ks;

Vox = Mox/rho_ox;
Vf = Mf/rho_f;

Mtot = Mox + Mf
Mudmh = 1260-1070
Vtot = Vox + Vf;
rho_p = Mtot/Vtot;

r = Mox/Mf;
Is = Isp;
Iv = rho_p * Is;
Itot = Is * Mtot * go;

%% calcolo udmh
%frozen 
Mmpe_u = 16.7;
Tc_u = 3415;
OF_u = 2.67;
gammac_u = 1.2107;
gammae_u = 1.2679;
Pc_u = 16500000; %bar
Pe_u = 51584; %bar
LAMDAe_u = sqrt(gammae_u*(2/(gammae_u+1))^((gammae_u+1)/(gammae_u-1)));
ks = 1.05;
%% calcoli di tutto

Isp2 = 2890.2/go;

Rsig_u = Ru/Mmpe_u;
ue_u = sqrt(((2*gammae_u)/(gammae_u-1))*Rsig_u*Tc_u*(1-(Pe_u/Pc_u)^((gammae_u-1)/gammae_u)));
mpunto_p_u = LAMDAe_u * Pc_u *At/ (sqrt(Rsig_u*Tc_u));
T_u = mpunto_p_u * ue_u + (Pe_u - Po) * Ae;

%% calcolo massa
rho_ox_u = 1440;
rho_f_u = 793;

mp_ox_u = mpunto_p_u*OF_u/(1+OF_u);
mp_f_u = mpunto_p_u * 1/(1+OF_u);
Mox_u = mp_ox_u * tbu * ks;
Mf_u = mp_f_u * tbu * ks;

Vox_u = Mox_u/rho_ox_u;
Vf_u = Mf_u/rho_f_u;

Mtot_u = Mox_u + Mf_u
%Mudmh = 1260-1070
Vtot_u = Vox_u + Vf_u;
rho_p_u = Mtot_u/Vtot_u;

Is_u = Isp2;
Iv = rho_p * Is_u;
Itot_u = Is_u * Mtot_u * go;

%% spinta
tu = Mtot_u/(mpunto_p_u)
Mtot_r = Mtot_u;
tbr = Mtot_r/(mpunto_p)
Itot_r = Isp * Mtot_r *go;

eta = 1/(Isp*go)
etau = 1/(Isp2*go)
