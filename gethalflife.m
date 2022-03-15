function halflife = gethalflife(zzz,aaa,stat)

t = readtable('.\naa-database\decaygammas.xls','Sheet','halflife');
z = (t{:,'z'}==zzz);
a = (t{:,'a'}==aaa);
sta = strcmp(t{:,'state'},stat);
num = find(z & a & sta);
if isempty(num)
    halflife = 0;
else
    halflife = t{num,'halflife'};
end
end % of function
