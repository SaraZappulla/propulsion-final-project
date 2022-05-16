function [PCpos,AApos,IS] = leggival(Isp,Pc,AeAt,PC,AA)

a = length(Pc);
b = length(AeAt);

for i = 1:a
    for j = 1:b
        if (Pc(i) == PC && AeAt(j) == AA)
            PCpos = i;
            AApos = j; 
            IS = Isp(j,i);
            return;
        end
    end
end
        