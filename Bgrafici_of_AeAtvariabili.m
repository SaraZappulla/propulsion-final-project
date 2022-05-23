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
Is = 3093.6/9.81;
Is2 = ones(A,O).*Is;
[MAX,a] = max(Is1)
[M,b] = max(Is1')
MM = zeros(13,13);
for i = 1:13
    for j = 1:46
        if (Of(j) == OO(i))
            MM(i,j) = M(i);
        end
    end
end
OO = Of(b)
figure(2)
surf(Of,AeAt,Is1)
hold on
surf(Of,AeAt,Is2)
%surf(6.6.*ones(length(Of),1),AeAt(1:2),Is1(1:2,:),'LineWidth',2)
%surf(6.7.*ones(length(Of),1),AeAt(2:3),Is1(2:3,:),'LineWidth',2)
%surf(6.8.*ones(length(Of),1),AeAt(3:5),Is1(3:5,:),'LineWidth',2)
%surf(6.9.*ones(length(Of),1),AeAt(5:11),Is1(5:11,:),'LineWidth',2)
%surf(7.*ones(length(Of),1),AeAt(11:13),Is1(11:13,:),'LineWidth',2)
hold on
title('Isp variation depending on O/F and Ae/At');
xlabel('O/F by mass');
ylabel('Ae/At');
grid on