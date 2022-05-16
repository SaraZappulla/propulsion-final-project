close all; clc; clear;

%Questo programma serve per ordinare e comparare i dati derivanti dal
%NASA-cea

%% Grafici 1 (Is in funzione di Pc e Ae/At) del propellente originale

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

Pc = [50
60
70
80
90
100
110
120
130
140
150
160
165
170
180
190];
AeAt = [10
12.5
15
17.5
20
22.5
25
26.2
27.5
30];
%32.5
%35
%37.5];
%Is1 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];
cf1 = rp1;
P = length(Pc);
A = length(AeAt);
C = length(cf1);

Cf1 = [];
k = 3;
for i = 1:P
    for j = 1:A
        Cf1(j,i) = cf1(k);
        k = k + 1;
    end
    k = k + 2;
end

figure(2)
surf(Pc,AeAt,log(Cf1))
hold on

%% Grafici 1 (Is in funzione di Pc e Ae/At) grafici RP-1

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

%Is2 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];
cf2 = udmh;
C2 = length(cf2);

Cf2 = [];
k = 3;
for i = 1:P
    for j = 1:A
        
        Cf2(j,i) = cf2(k);
        k = k + 1;
    end
    k = k + 2;
end

figure(2)
surf(Pc,AeAt,log(Cf2))

%%
PC = 165;
AA = 26.2;


[PCpos,AApos,CF] = leggival(Cf2,Pc,AeAt,PC,AA)
[cf1ret,cf1val] = confronto_val(Cf1,Pc,AeAt,CF)
[cf2ret,cf2val] = confronto_val(Cf2,Pc,AeAt,CF)

