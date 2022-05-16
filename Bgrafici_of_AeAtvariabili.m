% Programma che crea un grafico 3d con i dati di O/F e Ae/At varibili
% Dati importati dal file di testo: 
% grafico_of_aeat_datiRP1H2O2
Of = [5:0.1:9.5]';

AeAt = [10 12.5 15 17.5 20 22.5 25 26.2 27.5 30 32.5 35 37.5];
O = length(Of);
A = length(AeAt);

Is1 = [];
k = 3;
for i = 1:O
    for j = 1:A
        Is1(j,i) = isp(k)*10^3/9.81;
        k = k + 1;
    end
    k = k + 2;
end
Is = 2890.2/9.81;
Is2 = ones(A,O).*Is;

figure(2)
surf(Of,AeAt,Is1)
hold on
surf(Of,AeAt,Is2)
hold on
title('Isp variation depending on O/F and Ae/At');
xlabel('O/F by mass');
ylabel('Ae/At');
grid on