Pc = [160
175
180];
AeAt = [10
15
20
25];
Isp = [1 10 100; 10 1 100; 50 100 10; 10 100 10];
PC = 160;
AA = 20;
[PCpos,AApos,IS] = leggival(Isp,Pc,AeAt,PC,AA);
[Isret,Isval] = confronto_val(Isp,Pc,AeAt,IS,PC,AA)
