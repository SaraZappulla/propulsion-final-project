% this programme compare three Isp data: 
% Isp1 = Range Isp Rp-1 Udmh with Pc = 130-190
% Isp2 = Isp UDMH original engine confinguration coming from NASA-CEA
% Isp3 = Range Isp Rp-1 Udmh with Pc = 155-185
% Data calculated with Ae/At = 26.2 O/F = 6.9 Pc_u = 165

% IMPORT DATA FROM: 
% Isp1: dati_fase3_nuovi_range130190
% Isp2: datifase3_nuovi_range155185
% import separated by a space
go = 9.81;
Isp2 = 2890.2/go;

Pc1 = [130:5:190];
Pc3 = [155:185];

Is1 = Isp1'./go;
Is3 = Isp3'./go;

figure(1)
plot(Pc1,(Is1.*(10^3)))
hold on
plot(Pc1,ones(13,1).*(Isp2))
grid on 
title('Specific impulse comparison');
xlabel('Pc[bar]');
ylabel('Isp[s]');
legend('H2O2/RP-1 Isp','Original engine fixed Isp');

figure(2)
plot(Pc3,(Is3.*(10^3)))
hold on
plot(Pc3,ones(31,1).*(Isp2))
grid on 
title('Specific impulse comparison shorter range');
xlabel('Pc[bar]');
ylabel('Isp[m/s]');
legend('H2O2/RP-1 Isp','Original engine fixed Isp');