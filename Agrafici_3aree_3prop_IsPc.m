clc; close all;
% Grafici di rendimento dei vari propellenti
% Dati con 1: Ae = 20
% Dati con 2: Ae = 26.5
% Dati con 3: Ae = 30
% Tutti i grafici hanno sulle ascisse un andamento di pressione e sulle
% ordinate i valori di Is per i diversi propellenti

%% Dati
% DATI IMPORTATI DAI FILE:
% grafico1_A3_H2O2_RP1
% grafico1_A3_H2O2_RP1
% grafico1_A3_H2O2_RP1
% PRESENTI NELLA CARTELLA: "data"
% Definisco:
% p = vettore delle possibili pressioni
% Parametri con la v finale indicano l'uso di ISP VACUUM
% IS_NU e IS_NU_v vettori che contengono i dati del N2O4/UDMH
% IS_HR e IS_HR_v vettori che contengono i dati di H2O2/RP1
% IS_NR e IS_NR_v vettori che contengono i dati di N2O4/RP1

Pc = [100,110,120,130,140,150,160,165,170,180,190,200];
x = [1:25];

IS_NU_1 = [];
IS_NU_2 = [];
IS_NU_3 = [];

%IS_NU_v1 = [];
%IS_NU_v2 = [];
%IS_NU_v3 = [];

IS_HR_1 = [];
IS_HR_2 = [];
IS_HR_3 = [];

%IS_HR_v1 = [];
%IS_HR_v2 = [];
%IS_HR_v3 = [];

IS_NR_1 = [];
IS_NR_2 = [];
IS_NR_3 = [];

%IS_NR_v1 = [];
%IS_NR_v2 = [];
%IS_NR_v3 = [];

p = length(Pc);
for i = 1:p
    a = 3*i-2;
    b = 3*i-1;
    c = 3*i
    IS_NU_1 = [IS_NU_1 IS_NU(a)/98.1];
    IS_NU_2 = [IS_NU_2 IS_NU(b)/98.1];
    IS_NU_3 = [IS_NU_3 IS_NU(c)/98.1];
    IS_HR_1 = [IS_HR_1 IS_HR(a)/98.1];
    IS_HR_2 = [IS_HR_2 IS_HR(b)/98.1];
    IS_HR_3 = [IS_HR_3 IS_HR(c)/98.1];
    IS_NR_1 = [IS_NR_1 IS_NR(a)/98.1];
    IS_NR_2 = [IS_NR_2 IS_NR(b)/98.1];
    IS_NR_3 = [IS_NR_3 IS_NR(c)/98.1];
end

%% Grafico unico Isp e più aree
g = 9.81;
figure(3)
hold on
plot(Pc,IS_NU_1,'r--');
plot(Pc,IS_NU_2,'r','LineWidth',1);
plot(Pc,IS_NU_3,'r-*');
plot(Pc,IS_HR_1,'b--');
plot(Pc,IS_HR_2,'b','LineWidth',1);
plot(Pc,IS_HR_3,'b-*');
plot(Pc,IS_NR_1,'k--');
plot(Pc,IS_NR_2,'k','LineWidth',1);
plot(Pc,IS_NR_3,'k-*');
title('Specific Impulse comparison using three area ratio');
xlabel('Chamber Pressure [bar]');
ylabel('Specific Impulse [s]');
legend('N2O4/UDMH Ae/At=20','N2O4/UDMH Ae/At=26.2','N2O4/UDMH Ae/At=30','H2O2/RP-1 Ae/At=20','H2O2/RP-1 Ae/At=26.2','H2O2/RP-1 Ae/At=30','N2O4/RP-1 Ae/At=20','N2O4/RP-1 Ae/At=26.2','N2O4/RP-1 Ae/At=30');
grid on
    

