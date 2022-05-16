function [Mp_2,Deltav] = calcolo_m2_iterato(Pay,du_tp,T_u2,Tr,Atot2,Atot1,t1,...
    t2,mi_2,mf_2,Msu_1,Mp_1,mpunto_p,rhoo,beta,alpha)
mi_1 = mf_2 + Msu_1 + Mp_1;
go = 9.81;
mf_1 = Msu_1 + mi_2;
Mp_2o = mf_1-mf_2; 
k = 0.0001 * Mp_2o;
toll = 0.001* Mp_2o;
toll2 = 0.01*du_tp;
Mfuel = [];
Mfuel(1) = Mp_2o - k;
par = 10000;
i = 2;
ks = 1.05;
mscelta1 = []; 
hs = 11000;
while (par >= toll && i<10^5)
    [g1,dv_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,t1,0,mi_1,mpunto_p,rhoo,0,go,0,0,alpha);
    Dv2 = du_tp - dv_1;
    a = 0;
    j = 1;
    mfuel_o = Mp_2o;
    while (a == 0 && mfuel_o>2*k)
        mfuel_o = Mp_2o + k * j;
        mi_2 = mfuel_o + mf_2;
        tb2 = mfuel_o/((Mp_2o/t2)*ks);
        hs = 11000;
        rhos = 0;
        
        [gu2,dv_2,vf2,hf2,gf2,rhos,hs] = calcolo_dv_drag_gm(vf1r,Atot2,T_u2,t1+tb2,t1,mi_2,Mp_2o/t2,rhoo,hf1r,gf1r,rhos,hs,beta);
        
        mscelta2 = 0;
        if dv_2 < (Dv2+toll2) && dv_2>(Dv2-toll2)
            a = 1
            mscelta2 = mfuel_o;
            mscelta1(i) = mfuel_o;
        end   
        j = j +1;
    end
    
    if mscelta2 == 0
    %    return
    else
        mi_1 = mf_2 + Mp_1 + Msu_1 + mscelta2;
    
        Mfuel(i) = mscelta2;
        pin = min(Mfuel);
        par = abs(Mfuel(i)-Mfuel(i-1))
    end
    i = i+1
end
i
[g1,dv_1,vf1r,hf1r,gf1r,rhos,hs] = calcolo_dv_drag_gm(0,Atot1,Tr,t1,0,mi_1,mpunto_p,rhoo,0,go,0,0,alpha);
Mp_2 = Mfuel(end);
plot(Mfuel)
dv_t = dv_2 + dv_1;
Deltav = dv_2;
Deltamf = Mp_2o - Mp_2;