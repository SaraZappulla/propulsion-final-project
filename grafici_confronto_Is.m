close all; clc; clear;

%Questo programma serve per ordinare e comparare i dati derivanti dal
%NASA-cea

%% Grafici 1 (Is in funzione di Pc e Ae/At) del propellente originale

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

Pc = [130:5:190];
Aet = [10
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

P = length(Pc);
A = length(Aet);
I = length(Is1);

Isp = [];
k = 2;
for i = 1:P
    for j = 1:A
        k = k + 1;
        Isp(j,i) = Is1(k);
    end
    k = k + 2;
end

figure(1)
surf(Pc,Aet,Isp)
hold on

%% Grafici 1 (Is in funzione di Pc e Ae/At) grafici RP-1

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

Pc = [160
175
180
190
200
210
220
230];
Aet = [10
15
20
25
30
35
40
45
46
47
48
49
50];
%Is1 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];

P = length(Pc);
A = length(Aet);
I = length(Is5);

Isp = [];
k = 2;
for i = 1:P
    for j = 1:A
        k = k + 1;
        Isp(j,i) = Is5(k);
    end
    k = k + 2;
end

figure(1)
surf(Pc,Aet,Isp)
hold on

[PCpos,AApos,IS] = leggival(Isp,Pc,AeAt,PC,AA)
[Isret,Isval] = confronto_val(Isp,Pc,AeAt,IS,PC,AA)

