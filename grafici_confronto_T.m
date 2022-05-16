%% Grafici 1 (Is in funzione di Pc e Ae/At) del propellente originale

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

Ae = 26.2;
tb = 108;

son1 = sonn*100;
rho1 = rhoo/10;

Pc = [130:5:190];

%dat = length(DATA(:,1));
%Is1 = [0 0 1 1 1 1 0 0 1 1 1 1 0 0 1 1 1 1];
%cf1 = DATA(1:dat,1);
%cstar1 = DATA(1:dat,5);
%Me1 = DATA(1:dat,2);
%son1 = DATA(1:dat,3);
%Pc = DATA(1:dat,4);
%rho1 = DATA(3:end,5);

ve1 = Me1.*son1;
mpunto1 = Ae.*ve1 .*rho1;
T1 = cf1.*cstar1.*mpunto1; 
Tm1 = cf1.*cstar1./tb;

r = 10.*(T1);
figure(1)
semilogy(Pc,((T1)))
hold on

figure(2)
plot(Pc,((Tm1)))
hold on

p1 = Tm1+(T1);
figure (3)
semilogy(Pc,p1)
hold on

%% provo a fare ottimizzazione
a = polyfit(Pc,((p1)),2)
y = polyval(a,Pc)
b = ((p1))-y
c = a(2) + 2.*a(3).*Pc
%c = a(2) + 2.*a(3).*Pc + 3.*a(4).*Pc.^2 + 4.*a(5).*Pc.^3
%d = 2.*a(3) + 6.*a(4).*Pc + 12.*a(5).*Pc.^2
%d = 6*a(4).*Pc + 24 .*a(5).*Pc
%d = 2.* 

figure(6)
plot(Pc,b)
title('Error function between Data and Approximate function');
xlabel('Pc[bar]');
ylabel('Error function[m/s^2]');
grid on
figure(4)
plot(Pc,c)
%figure(6)
%plot(Pc,d)
figure(5)
plot(Pc,y)
hold on
plot(Pc,p1)
legend('b','c','y')

%% 

cf2 = 1.7748;
Me2 = 3.891;
son2 = 706.1;
Pc2 = 165; 
cstar2 = 1660.9;
rho2 = 0.087298;

ve2 = Me2*son2;
mpunto2 = Ae*ve2 *rho2;
T2 = cf2*cstar2*mpunto2; 
Tm2 = cf2*cstar2/tb;
p2 = Tm2 + log(T2)

figure(1)
semilogy(Pc,ones(31,1).*((T2)))
hold on
grid on 
title('Thrust comparison');
xlabel('Pc[bar]');
ylabel('T[N]');
legend('H2O2/RP-1 Thrust','Original engine fixed Thrust');

figure(2)
plot(Pc,ones(31,1).*((Tm2)))
hold on
grid on 
title('Thrust over mass comparison');
xlabel('Pc[bar]');
ylabel('T/m[m/s^2]');
legend('H2O2/RP-1 Thrust/mass','Original engine fixed Thrust/mass');

figure (3)
semilogy(Pc,ones(31,1).*p2)
grid on 
title('Thrust/mass + Thrust/1kg comparison');
xlabel('Pc[bar]');
ylabel('T/m[m/s^2]');
legend('H2O2/RP-1 Thrust/mass function','Original engine fixed Thrust/mass function');
