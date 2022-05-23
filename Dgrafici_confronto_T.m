% This program allow to calculate T and T/m of the new propulsor 

% DATA IMPORTED FROM: 
% dati_fase3_nuovi_range130190
% datifase3_nuovi_range155185
% import separated by a space
% These above are two different data range that can be run only one at the
% time, and compared with UDMH/N2O4 data

% Pc = Pressione in camera di combustione
% Of = Rapporto O/F
% Aet = Rapporto Ae/At 
% ...

Ae = 1.5^2/4 * pi
tb = 119.7;

son1 = sonn*100;
rho1 = rhoo/10;

%Pc = [130:5:190];

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
plot(Pc,((T1)))
hold on

figure(2)
plot(Pc,((Tm1)))
hold on


%% UDMH

tt = length(Tm1)
cf2 = 1.7835;
Me2 = 3.8353;
son2 = 718.75;
Pc2 = 165; 
cstar2 = 1696.7;
rho2 = 0.12582;

ve2 = Me2*son2;
mpunto2 = Ae*ve2 *rho2;
T2 = cf2*cstar2*mpunto2; 
Tm2 = cf2*cstar2/tb;
p2 = Tm2 + log(T2)

figure(1)
plot(Pc,ones(tt,1).*T2)
hold on
grid on 
title('Thrust comparison');
xlabel('Pc[bar]');
ylabel('T[N]');
legend('H2O2/RP-1 Thrust','Original engine fixed Thrust');

figure(2)
plot(Pc,ones(tt,1).*Tm2)
hold on
grid on 
title('Thrust over mass comparison');
xlabel('Pc[bar]');
ylabel('T/m[m/s^2]');
legend('H2O2/RP-1 Thrust/mass','Original engine fixed Thrust/mass');
%% provo a fare ottimizzazione
% OPZIONE 1: COMPARAZIONE CON FUNZIONE LINEARE
%a = polyfit(Pc,Tm1,1)
%y = polyval(a,Pc)
%b = Tm1-y

% OPZIONE 2: COMPARAZIONE CON FUNZIONE QUADRATICA
lin = [-1.5*10^-3,1.5*10^-3]
a = 0;
for i = 1:tt
    if (T1(i) >= T2 && a==0)
        PP = Pc(i);
        a = 1;
    end
end
Plin = [PP,PP]
a = polyfit(Pc,Tm1,2)
y = polyval(a,Pc)
b = Tm1-y
[T3,T4] = maxk(b,3)
vect1 = T3
vect2 = T4
figure(6)
plot(Pc,b,'k')
hold on
plot(Pc(vect2),vect1,'*b','LineWidth',2)
plot(Plin,lin,'r')
title('Error function between Data and Approximate function');
xlabel('Pc[bar]');
ylabel('Error function[m/s^2]');
grid on

