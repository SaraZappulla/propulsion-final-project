close all; clc; 

AeAt = [24.0:0.1:27.5];
A = length(AeAt);

tb = [];
Mtot = [];
Vtot = [];
Isp = [];
eta = [];
j = 0;
for i = 1:A
    j = j+1;
    tb(i) = DATA(j);
    j = j+1;
    Mtot(i) = DATA(j);
    j = j+1;
    Vtot(i) = DATA(j);
    j = j+1;
    Isp(i) = DATA(j);
    j = j+1;
    eta(i) = DATA(j);
end
T = mean(tb);
M = mean(Mtot);
I = mean(Isp);
V = mean(Vtot);
E = mean(eta);
figure(1)
plot(AeAt,tb);
figure(2)
plot(AeAt,Mtot);
figure(3)
plot(AeAt,Vtot);
figure(4)
plot(AeAt,Isp);
figure(5)
plot(AeAt,eta);

%% graphs

figure(6)
hold on;
grid on;
plot(AeAt,tb./T);
plot(AeAt,Mtot./M,'o-');
plot(AeAt,Vtot./V,'--','LineWidth',2);
plot(AeAt,Isp./I);
plot(AeAt,eta./E,'*-');
xlabel('Ae/At');
ylabel('Normalized parameters');
title('Comparison of normalized parameters');
legend('tb','Mp','Vp','Isp','eta')

%% numbers
K = find(AeAt == 25.5);
J = K+5;
f = fopen('Dati_grafico_E.txt','w');
AE = AeAt(K:J);
TB = tb(K:J);
MTOT = Mtot(K:J);
VTOT = Vtot(K:J);
ISP = Isp(K:J);
ETA = eta(K:J);
fprintf(f,'Ae/At       tb        Mtot        Vtot        Isp        eta');
for i = 1:length(AE)
    %B = [AE(i),TB(i),MTOT(i),VTOT(i),ISP(i),ETA(i)]
    fprintf(f,'\n%f %f %f %f %f %e',AE(i),TB(i),MTOT(i),VTOT(i),ISP(i),ETA(i));
end
fclose(f);
