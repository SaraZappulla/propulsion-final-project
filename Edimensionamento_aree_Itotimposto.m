close all; clc;
% This program allow to calculate burning time, propellant mass, propellant
% volume, specific propellant consumption and specific impulse of one
% engine. Data are distinguished by Ae/At that is changing between 20 and
% 27.5
% Data are calculated using NASA-CEA and taking the plot outcome 

% IMPORT DATA FROM:
% DATI_fase4

% Important data are printed in file: 
% Dati_grafico_E.txt

Po = 101325;
Ru = 8314;
Mmp = 21.7;
Mmpe = 22.316;
Tc = 3045.94;
OF = 6.9;
go = 9.81;
Pc = 16600000; %Pa
AeAt = 26.2;
tbu = 119.7;
De = 1.431; %m ovvero 0.069 di spessore
Ae = pi * De^2/4;
At = Ae/AeAt;
AcAt = 1.54;
Ac = AcAt*At;
ks = 1.05;

%% calcolo udmh
%frozen 
Mmpe_u = 16.7;
Tc_u = 3526.33;
OF_u = 2.67;
gammae_u = 1.2700;
Pc_u = 16500000; %Pa
Pe_u = 51179; %bar
LAMDAe_u = sqrt(gammae_u*(2/(gammae_u+1))^((gammae_u+1)/(gammae_u-1)));
ks = 1.05;

%% calcoli UDMH

Isp2 = 2950.1/go;

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
tb = 119.7;
Pc = 16600000; %bar

Isph = Isp./go;
%end
LAMDAe = sqrt(gammae.*(2./(gammae+1)).^((gammae+1)./(gammae-1)));
At_r = Ae./AeAt_r;
Ac_r = AcAt.*At_r;

Rsig = Ru/Mmpe;
ue_id = sqrt(((2.*gammae)./(gammae-1)).*Rsig.*Tc.*(1-(Pe./Pc).^((gammae-1)./gammae)));
mpunto_p = LAMDAe .* Pc .*At_r./ (sqrt(Rsig*Tc));
T = mpunto_p .* ue_id + (Pe - Po) .* Ae;

%% calcolo massa RP1
rho_ox = 1450;
rho_f = 810;

mp_ox = OF/(1+OF) .* mpunto_p;
mp_f = 1/(1+OF) .* mpunto_p;
tu = Mtot_u./(mpunto_p_u.*ks)
Mtot_r = Itot_u./(Isph*go)
tbr = Mtot_r./(mpunto_p.*ks)
Itot_r = Isph .* Mtot_r .*go;

Mox = mp_ox .* tbr .* ks;
Mf = mp_f .* tbr .* ks;

Vox = Mox./rho_ox;
Vf = Mf./rho_f;
Vtot = Vox + Vf;
rho_p_r = Mtot_r./Vtot;

r = Mox./Mf;
Is = Isph;
Iv = rho_p_r .* Isph;
Itot = Isph .* Mtot_r .* go;

%% spinta
eta = 1./(Isph.*go)
etau = 1./(Isp2.*go)

%%
M = mean(Mtot_r);
V = mean(Vtot);
ETA = mean(eta);
TBR = mean(tbr);
ISP= mean(Isph);
figure(1)
hold on
grid on
plot(AeAt_r(13:25),tbr(13:25)./TBR)
plot(AeAt_r(13:25),Mtot_r(13:25)./M,'--','LineWidth',2)
plot(AeAt_r(13:25),Vtot(13:25)./V,'-o')
plot(AeAt_r(13:25),Isph(13:25)./ISP)
plot(AeAt_r(13:25),eta(13:25)./ETA,'*-')
xlabel('Ae/At');
ylabel('Normalized parameters');
title('Comparison of normalized parameters');
legend('tb','Mp','Vp','Isp','eta')

%% FILE
K = find(AeAt_r == 25.5);
J = K+6;
f = fopen('Dati_grafico_E.txt','w');
AE = AeAt_r(K:J);
TB = tbr(K:J);
MTOT = Mtot_r(K:J);
VTOT = Vtot(K:J);
ISP = Isph(K:J);
ETA = eta(K:J);
fprintf(f,'Ae/At       tb        Mtot        Vtot        Isp        eta');
for i = 1:length(AE)
    %B = [AE(i),TB(i),MTOT(i),VTOT(i),ISP(i),ETA(i)]
    fprintf(f,'\n%f %f %f %f %f %e',AE(i),TB(i),MTOT(i),VTOT(i),ISP(i),ETA(i));
end
fclose(f);

%% volume totale
% Lstar = 1.52 o 1.78
%Lstar = 1.52;
%Vc = Ac * Lstar;

% Devo mettere anche il volume dell'ugello?
%Vtot_m = Vtot + Vc;
%di 25.8
tbr = tbr(20)
Mtot = Mtot_r(20)
Vtot = Vtot(20)
Isph = Isph(20)
eta = eta(20)
Tr = T(20)
mpunto_p = mpunto_p(20)