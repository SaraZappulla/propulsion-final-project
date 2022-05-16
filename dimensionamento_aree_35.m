close all; clc; clear;

%frozen 
Po = 101325;
Ru = 8314;
Mmp = 21.7;
Mmpe = 22.316;
Tc = 3046.32;
OF = 6.9;
go = 9.81;
Pc = 16600000; %Pa
AeAt = 26.2;
tbu = 108;
De = 1.431; %m ovvero 0.069 di spessore
Ae = pi * De^2/4;
At = Ae/AeAt;
AcAt = 1.54;
Ac = AcAt*At;
ks = 1.05;

%% calcolo udmh
%frozen 
Mmpe_u = 16.7;
Tc_u = 3415;
OF_u = 2.67;
gammae_u = 1.2679;
Pc_u = 16500000; %bar
Pe_u = 51584; %bar
LAMDAe_u = sqrt(gammae_u*(2/(gammae_u+1))^((gammae_u+1)/(gammae_u-1)));
ks = 1.05;

%% calcoli UDMH

Isp2 = 2890.2/go;

Rsig = Ru/Mmpe_u;
ue_u = sqrt(((2*gammae_u)/(gammae_u-1))*Rsig*Tc_u*(1-(Pe_u/Pc_u)^((gammae_u-1)/gammae_u)));
mpunto_p_u = LAMDAe_u * Pc_u *At/ (sqrt(Rsig*Tc_u));
T_u = mpunto_p_u * ue_u + (Pe_u - Po) * Ae;

%% calcolo massa UDMH
rho_ox_u = 1440;
rho_f_u = 793;

mp_ox_u = mpunto_p_u*OF_u/(1+OF_u);
mp_f_u = mpunto_p_u * 1/(1+OF_u);
Mox_u = mp_ox_u * tbu * ks;
Mf_u = mp_f_u * tbu * ks;

Vox_u = Mox_u/rho_ox_u;
Vf_u = Mf_u/rho_f_u;

Mtot_u = Mox_u + Mf_u;
Vtot_u = Vox_u + Vf_u;
rho_p_u = Mtot_u/Vtot_u;

Is_u = Isp2;
Iv = rho_p_u * Is_u;
Itot_u = Is_u * Mtot_u * go;
%% calcoli RP1
gammae = 1.2285;
AeAt_r = 26.2;
tb = 92.4243;
Pe = 59088;
Isp = 2912.4/go;

LAMDAe = sqrt(gammae*(2/(gammae+1))^((gammae+1)/(gammae-1)));
At_r = Ae/AeAt_r;
Ac_r = AcAt*At_r;

Rsig = Ru/Mmpe;
ue_id = sqrt(((2*gammae)/(gammae-1))*Rsig*Tc*(1-(Pe/Pc)^((gammae-1)/gammae)));
mpunto_p = LAMDAe * Pc *At_r/ (sqrt(Rsig*Tc));
T = mpunto_p * ue_id + (Pe - Po) * Ae;

%% calcolo massa RP1
rho_ox = 1450;
rho_f = 810;

mp_ox = OF/(1+OF) * mpunto_p;
mp_f = 1/(1+OF) * mpunto_p;
tu = Mtot_u/(mpunto_p_u)
Mtot_r = Itot_u/(Isp*go)
tbr = Mtot_r/(mpunto_p)
Itot_r = Isp * Mtot_r *go;

Mox = mp_ox * tbr * ks;
Mf = mp_f * tbr * ks;

Vox = Mox/rho_ox;
Vf = Mf/rho_f;
%Mtot = Mox + Mf
%Mudmh = 1260-1070;
Vtot = Vox + Vf;
%rho_p = Mtot/Vtot;
rho_p_r = Mtot_r/Vtot;

r = Mox/Mf;
Is = Isp;
Iv = rho_p_r * Is;
Itot = Is * Mtot_r * go;

%% spinta
eta = 1/(Isp*go)
etau = 1/(Isp2*go)
