
%inserisco di seguito le funzioni che ci potrebbero servire per un
%endoreattore

Rsig = Ru/Mm;
Ve = sqrt(2*cp*Tc*(1-(Tc/Te)));
perc_reale = 0.98;
%Is = impulso specifico ponderale
%Itot = impulso totale
%Is_ms = impulso in metri al secondo
%Iv = impulso specifico volumetrico
%T = spinta
%mpunto_p = portata massica propellente
%g0 = accelerazione di gravità a z = 0
%gamma = coef gas
%Mm = massa molecolare gas
%Tc = Temperatura in camera di combustione
%Pe = pressione efflusso
%Pc = pressione camera di combustione
%Mp = massa totale del propellente
%tb = tempo di funzionamento
%ro = densità

Is = T/(mpunto_p*g0);
Is = Ve/go;
Is = 1/g0 * sqrt(((2*gamma)/(gamma-1))*R*Tc/Mm*(1-(Pe/Pc)^((gamma-1)/gamma)));
Is_ms = Is*g0;
Itot = Is * Mp;
Itot = T * tb;

Iv = ro * Is;

T = mpunto_p * ve + (Pe - Po) * Ae;
veff = ve + (Pe-Po)*Ae/mpunto_p;
%eta_th = rendimento termico
%eta_pr = rendimento propulsivo
%eta_gl = rendimento globale
%dh_p = delta di entalpia del propellente
%vo = velocità in ingresso
r = vo^2 / ve^2;

eta_th = (1+r)/(r^2*(2*dh_p/vo^2+1)); %credo che sia 0
eta_pr = 2*r / (1+r);
eta_gl = 2/(r*(2*dh_p/vo^2+1));
vo = sqrt(2*dh_p);          %vo che rende eta_gl max

%FW = rapporto spinta peso 
%W = peso
%OF = massa ossidante su massa fuel;
FW = T/W;
OF = O/F;

%ct = coeff. di spinta
%At = area di gola dell'ugello
%cd = coeff. di efflusso
%cstar = velocità caratteristica
ct = T / (Pc*At);
cd = mpunto_p / (Pc*At);
cstar = 1/cd;
cstar = (sqrt(R*Tc/Mm))/LAMDA;
ct = LAMDA * sqrt(((2*gamma)/(gamma-1))*(1-(Pe/Pc)^((gamma-1)/gamma)));

T = mpunto_p * ct * cstar;
Is = ct * cstar / go;

%LAMDA = funzione di Vanderkankove
LAMDA = sqrt(gamma*(2/(gamma+1))^((gamma+1)/(gamma-1)));

%funzione di tsiolkovsky
%MR = rapporto di massa
%m_f = massa finale
%m_i = massa iniziale
%dv = v finale - v iniziale
MR = m_f / m_i;
dv = -go*Is*ln(MR);

%equazioni fondamentali del moto 
%M_f = massa finale
%M_p = massa totale propellente
%epsilon = frazione di massa propellente
%Cd = coeff. di resistenza
%csig = c segnato

MR = (Mf/(Mf+Mp));
epsilon = Mp/Mo;
epsilon = 1 - MR;

dv_dt = (Veff * epsilon/tb)/(1-epsilon*t/tb) - g0*sin(teta) - (Cd/2*ro*v^2*a/m_i)/(1-epsilon*t/tb);
v_p = csig * ln(1/MR) - gsig * tb;

%multistadio
epsilon_u(i) = Mo(i+1)/(Mo(i)-Mo(i+1));
epsilon_s(i) = Ms(i)/(Mo(i)-Mo(i+1));
mo_mf(i) = (1+epsilon_u(i))/(epsilon_s(i)-epsilon_u(i));
mo_mf(i) = 1/MR(i);
dv(i) = go*Is(i)*ln(1/MR(i));

%Lstar = lunghezza caratteristica
%Vcc = volume camera di combustione
%tcar = tempo caratteristico
%vsp = volume specifico propellente
%phi = rapporto di equivalenza
%OFs = O/F stechiometrico
%EA = eccesso d'aria
Lstar = Vcc/At;
tcar = Vcc/(mpunto_p*vsp);

phi = OF/OFs;
EA = phi - 1;

%ugello
%eta_n = rendimento ugello (calcolo con delta h
%Ver = Ve reale
%Vei = Ve ideale
%epsilon = rapporto fra le aree+
%alpha = semi angolo di divergenza dell'ugello
%ugcamp = lunghezza ugello campana
%perc = percentuale di campana
%ugcon = lunghezza ugello conico
epsilon = Ae / Astar;
epsilon = 1/(((gamma+1)/2)^(1/(gamma-1))*(Pe/Pc)*sqrt((gamma+1)/(gamma-1)*(1-(Pe/Pc)^((gamma-1)/gamma))));
Ve = sqrt(((2*gamma)/(gamma-1))*R*Tc/Mm*(1-(Pe/Pc)^((gamma-1)/gamma)));
Ver = Vei * sqrt(eta_n);

Ae = pi * r^2 * (1 - (cos(alpha))^2);
Ae2D = 2*pi * r^2 * (1 - cos(alpha));
T2D = mpunto_p * Ve * (1+cos(alpha))/2 + (Pe - Po) * Ae;

Lugcamp = perc * Lugconi;

Lugtot = Lconv + Ldivb;

alpha = atan((re-rt)/Ldiv);
Lconv = (rc-rt)/tg(beta);
rc = (Dc - 2*thick)/2;

mpunto_p = LAMDA * Pc * At /(sqrt(Rsig*Tc));
Ae = epsilon * At;
mpunto_p = roe * Ae * ue;
%Mc fra 0.2 e 0.6
uc = Mc * Ac;
roc = Pc /(Rsig * Tc);
%ks fattore di sicurezza 0.05
mpunto_p = mpunto_ox + mpunto_f
Mox = mpunto_ok * tb * ks;
Mfu = mpunto_fu * tb * ks;
Vox = Mox/roox;
Vfu = Mfu/rofu;
Mtot = Mox + Mfu;
Vtot = Vox + Vfu;
rop = Mtot/Vtot;

Alat = pi * Dc * Lc;

%iniettori
%dP = perdite di pressione (0.05-0.3)*Pc
Cd = mpunto_r/mpunto_id;
A1h = pi * D1h^2 /4;

Ahox = mpunto_ox/(Cd*sqrt(roox*2*dP));
Ahfu = mpunto_fu/(Cd*sqrt(rofu*2*dP));

Nhox = Ahox/A1h;
Nhfu = Ahfu/A1h;
mpunto_id = sqrt(2*dP*ro)*A1h;

%design piatto iniezione
%beta = angolo di deviazione del fluido 
uox = cd * sqrt(2*dP/roox);
ufu = cd * sqrt(2*dP/rofu);
beta_fu = atan(mpunto_ox*uox/(mpunto_fu*ufu)*sin(beta_ox));

%Pressurizzazzione
Ptank = Pc + dPfeed + dPinj + dPdyn;
%dPfeed circa 50kPa perdite di pressione nei tubi
%dPinj = perdire di pressione negli iniettori 
dPinj = 0.1*Pc;
dPdyn = 1/2 * ro * vp_real^2;

