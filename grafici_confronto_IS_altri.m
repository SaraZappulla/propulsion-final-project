%% Grafici 1 (Is in funzione di Pc e O/F)

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

Pc = [20 40 50];
OF = [1 3 5 10];
Is2 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];

P = length(Pc);
O = length(Aet);
I = length(Is2);

Isp = [];
k = 2;
for i = 1:P
    for j = 1:O
        k = k + 1;
        Isp(j,i) = Is2(k);
    end
    k = k + 2;
end

figure(2)
surf(Pc,OF,Isp)

%% Grafici 1 (Is in funzione di O/F e Ae/At)

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

OF = [20 40 50];
Aet = [1 3 5 10];
Is3 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];

O = length(Pc);
A = length(Aet);
I = length(Is3);

Isp = [];
k = 2;
for i = 1:O
    for j = 1:A
        k = k + 1;
        Isp(j,i) = Is3(k);
    end
    k = k + 2;
end

figure(3)
surf(OF,Aet,Isp)