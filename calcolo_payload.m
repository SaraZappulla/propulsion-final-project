function [Mpayscelta,Deltav,Deltam] = calcolo_payload(du_tot,Atot1,Atot2,Atot3,Atot4,mpunto_p,Mp_1,Mp_2,...
    Mp_3,Mp_4,Ms_1,Ms_2,Ms_3,Ms_4,Mpay,alpha,beta,Tr,T_u2,T_u3,T_u4,t1,t2,t3,t4)

rhoo = 1.225;
go = 9.81;
mi_4 = Ms_4 + Mpay + Mp_4; 
mf_4 = Ms_4 + Mpay;
mi_3 = Ms_3 + mi_4 + Mp_3; 
mf_3 = Ms_3 + mi_4;
mi_2 = Ms_2 + mi_3 + Mp_2; 
mf_2 = Ms_2 + mi_3;
mi_1 = Ms_1 + mi_2 + Mp_1; 
mf_1 = Ms_1 + mi_2;
% mi servonon tutte le masse dei vari stadi

k = 0.1 * Mpay;
toll = 0.1 * Mpay;
toll2 = 0.1 * du_tot;
par = 100000;
i = 0;

while (par >= toll && i<10^2)
    rhos = 0;
    hs = 11000;
    [g1,dv_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,t1,0,mi_1,...
        mpunto_p,rhoo,0,go,0,0,alpha);
    [gu2,dv_2,vf2,hf2,gf2,rhos,hs] = calcolo_dv_drag_gm(vf1r,Atot2,T_u2,t1+t2,t1,...
        mi_2,Mp_2/t2,rhoo,hf1r,gf1r,rhos,hs,beta);
    [gu3,dv_3,vf3,hf3,gf3,rhos,hs] = calcolo_dv_drag_gm(vf2,Atot3,T_u3,t1+t2+t3,...
        t1+t2,mi_3,Mp_3/t3,rhoo,hf2,gf2,rhos,hs,0)

    Dv4 = du_tot - dv_1 - dv_2 - dv_3;

    a = 0;
    j = 1;
    PAY = Mpay;
    while (a == 0 && PAY>2*k)
        PAY = Mpay - k * j;
        mi_4 = PAY + Mp_4 + Ms_4;
        hs = 11000;
        rhos = 0;
        
        %per il 4
        [gu4,dv_4,vf4,hf4,gf4,rhos,hs] = calcolo_dv_drag_gm(vf3,Atot4,T_u4,t1+t2+t3+t4,...
            t1+t2+t3,mi_4,Mp_4/t4,rhoo,hf3,gf3,rhos,hs,0);
        
        mscelta2 = 0;
        if dv_4 < (Dv4+toll2) && dv_4>(Dv4-toll2)
            a = 1
            mscelta2 = PAY;
            mscelta1(i) = PAY;
        end   
        j = j +1
    end
    
    if mscelta2 == 0
    %    return
    else
        %per tutte le masse
        mf_4 = Ms_4 + mscelta2;
        mi_3 = Ms_3 + mi_4 + Mp_3; 
        mf_3 = Ms_3 + mi_4;
        mi_2 = Ms_2 + mi_3 + Mp_2; 
        mf_2 = Ms_2 + mi_3;
        mi_1 = Ms_1 + mi_2 + Mp_1; 
        mf_1 = Ms_1 + mi_2;
        
        MM(i) = mscelta2;
        pin = min(MM);
        par = abs(MM(i)-MM(i-1))
    end
    i = i+1
end
i
[g1,dv_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,t1,0,mi_1,mpunto_p,rhoo,0,go,0,0,alpha);
[gu2,dv_2,vf2,hf2,gf2,rhos,hs] = calcolo_dv_drag_gm(vf1r,Atot2,T_u2,t1+t2,t1,mi_2,Mp_2/t2,rhoo,hf1r,gf1r,rhos,hs,beta)
[gu3,dv_3,vf3,hf3,gf3,rhos,hs] = calcolo_dv_drag_gm(vf2,Atot3,T_u3,t1+t2+t3,...
    t1+t2,mi_3,Mp_3/t3,rhoo,hf2,gf2,rhos,hs,0);
Mpayscelta = MM(end);
plot(MM)
dv_t = dv_4 + dv_3 + dv_2 + dv_1;
Deltav = dv_t - du_tot;
Deltam = Mpay - Mayscelta;