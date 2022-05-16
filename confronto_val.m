function [Isret,Isval] = confronto_val(Isp,Pc,AeAt,IS,PC,AA)

%Isp è la matrice degli impulsi specifici
%Pc è il vettore delle pressioni
%AeAt è il vettore dei rapporti di aree
%IS PC AA sono i valori esatti
r = length(Isp(1,:));
c = length(Isp(:,1));
P = length(Pc);
A = length(AeAt);

if(r~= P || c ~=A)
    printf('error');
end

%% grafico
surf(Pc,AeAt,Isp);
hold on;
Isx = IS * ones(c,r);
surf(Pc,AeAt,Isx)

%% dati numerici

Isret = [];
Isval = [];
for i = 1:r
    for j = 1:c
        v1 = Isp(j,i);
        if v1 >= IS
            Isval(j,i) = v1;
            Isret(j,i) = 1;
        end
    end
end
        