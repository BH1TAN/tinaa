function table_gamma = tinaa(table_specimen,matName,ttt)
% TINAA
% 
load(matName,'table*','spec_neutron');
tradi = ttt(1); 
tcool = ttt(2);
tmeas = ttt(3);
%% fill in table_element
table_element{:,'mass_g'}=0;
for i = 1:size(table_specimen,1)
    table_element{table_specimen{i,1}{1,1},'mass_g'} = table_specimen{i,2};
end

%% fill in table_isotope
table_isotope{:,'n_mol'} = 0;
for i = 1:size(table_isotope,1)
    thisZ = table_isotope{i,'z'};
    eleNo = find(table_element{:,'z'}==thisZ);
    table_isotope{i,'n_mol'} = ...
        table_element{eleNo,'mass_g'}/table_element{eleNo,'atomicweight'}*table_isotope{i,'abun'};
end

%% fill in table_decay
table_decay{:,'nsat'}=0;
for i = 1:size(table_decay,1)
    thisZ = table_decay{i,'z'};
    thisA = table_decay{i,'a'}-1;
    decayConst = (log(2)/table_decay{i,'halflife_s'});
    isoNo = find(table_isotope{:,'z'}==thisZ & table_isotope{:,'a'}==thisA);
    table_decay{i,'nsat'} = ...
        table_isotope{isoNo,'n_mol'}*0.602*table_decay{i,'int_part'}/decayConst;
end

%% fill in table_gamma
table_gamma{:,'ngamma'} = 0;
for i = 1:size(table_gamma,1)
    thisIso = table_gamma{i,'radnuc'}{1,1};
    decayConst = (log(2)/table_gamma{i,'halflife_s'});
    table_gamma{i,'ngamma'} = ...
        table_decay{thisIso,'nsat'}*table_gamma{i,'branch'} * ...
        (1-exp(-decayConst*tradi))*exp(-decayConst*tcool)*(1-exp(-decayConst*tmeas));
end

save('result','table*','ttt','spec_neutron');
end

