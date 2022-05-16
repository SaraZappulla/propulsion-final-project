function [gm,vd,vend,hend,gend,rhos,hs] = calcolo_dv_drag_gm(vo,S,T,ttot,to,Mo,mpunto,rhoo,ho,go,rhos,hs,A)

Cd = 0.75;
%go = 9.81;
R = 6378388; %raggio terra in m
TIME = [to:ttot];
TOT = length(TIME);
i = 1;
% condizioni di traiettoria: 82°
At = sin(A);
Bt = cos(pi/2-A);
g = zeros(TOT+1,1);
v = zeros(TOT+1,1);
M = zeros(TOT+1,1);
rho = zeros(TOT+1,1);
h = zeros(TOT+1,1);
D = zeros(TOT+1,1);
a = zeros(TOT+1,1);
W = zeros(TOT+1,1);
g(i) = go;
v(i) = vo;
M(i) = Mo;
rho(i) = rhoo;
h(i) = ho; 
W(i) = M(i) * g(i);
D(i) = 0.5 * rhoo * vo^2 * Cd * S;
a(i) = (T - D(i)- W(i)*At)/Mo;
for i = 2:(TOT+1)
    %alpha = -(pi/3)/((ttot-to)^3) * (i-1)^3 + pi/2
    %At = sin(alpha);
    M(i) = Mo - mpunto * (i-1);
    W(i) = g(i) * M(i);
    v(i) = v(i-1) + a(i-1) * 1;
    D(i) = 0.5 * rho(i-1) * v(i)^2 * Cd * S;
    a(i) = (T - D(i) - W(i)*At)/(M(i));
    v(i) = v(i-1) + a(i)*1;
    %v(i) = v(i)/10; % problema con unità di misura
    h(i) = h(i-1) + v(i)*1*At + 0.5*a(i)*1*At;
     %km
    g(i) = go * (R/(R+h(i)))^2;
    if h(i) < 11000
        h(i); %km
        lambda = -6.5*10^(-3);
        theta = 288.15 + lambda*(h(i));
        rho(i) = rhoo * (theta/288.15)^(-(1+(9.81/(8.31*lambda))));
        rhos = rho(i);
        hs = h(i);
        else if (h(i) > 11000 && h(i) < 40000)
        d = 3;
        lambda = 0;
        thetas = 216.65;
        rho(i) = rhos * exp(-(9.81/(8.31*thetas))*(h(i)-hs));
        h(i);
            else
                k = 4;
                rho(i) = 0;
            end
    end
   
end

gm = (sum(g))/(TOT+1);
vd = v(TOT+1)-v(1);

vend = v(TOT+1);
hend = h(TOT+1);
gend = g(TOT+1);