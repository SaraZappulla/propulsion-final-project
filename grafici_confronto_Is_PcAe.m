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
30
32.5
35
37.5
40
42.5
45
47.5
50
52.5
55
57.5];
%Is1 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];
Is1 = RP11;
P = length(Pc);
A = length(AeAt);
I = length(Is1);

Isp1 = [];
k = 3;
for i = 1:P
    for j = 1:A
        Isp1(j,i) = Is1(k);
        k = k + 1;
    end
    k = k + 2;
end

figure(2)
surf(Pc,AeAt,Isp1)
hold on

%% Grafici 1 (Is in funzione di Pc e Ae/At) grafici RP-1

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

%Is2 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];
Is2 = UDMH1;
I2 = length(Is2);

Isp2 = [];
k = 3;
for i = 1:P
    for j = 1:A
        Isp2(j,i) = Is2(k);
        k = k + 1;
    end
    k = k + 2;
end

figure(2)
surf(Pc,AeAt,Isp2)

PC = 165;
AA = 26.2;

%%
%IS = 3.0924
[PCpos,AApos,IS] = leggival(Isp2,Pc,AeAt,PC,AA)
[Isret,Isval] = confronto_val(Isp1,Pc,AeAt,IS)
[Isret,Isval] = confronto_val(Isp2,Pc,AeAt,IS)


