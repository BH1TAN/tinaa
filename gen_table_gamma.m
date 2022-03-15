function table_gamma = gen_table_gamma(sourceName,table_decay)
% Generate table of decay gammas
% Input:
%    sourceName: filename or path of the data containing the decay gamma
%    and their intensities
%    table_decay: table containing decay isotopes
energy_MeV = [];
radnuc = cell(0,0);
z = [];
a = [];
state = cell(0,0);
halflife_s = [];
branch = [];
disp('Storing the decay gammas of table_gamma');
for i = 1:size(table_decay,1)
    processbar(i,size(table_decay,1),10);
    thisZ = table_decay{i,'z'};
    thisA = table_decay{i,'a'};
    thisS = table_decay{i,'stat'}{1,1};
    if strcmp(thisS,'g')
        fileName = [sourceName,'\','decay_',num2str(thisZ),'_',num2str(thisA),'.txt'];
    else
        fileName = [sourceName,'\','decay_',num2str(thisZ), ...
            '_',num2str(thisA),'_',thisS,'.txt'];
    end
    if exist(fileName)
        gammas = importdata(fileName);
        for j = 1:size(gammas,1)
            energy_MeV = [energy_MeV;gammas(j,1)];
            radnuc = [radnuc;table_decay.Properties.RowNames{i}];
            z = [z;table_decay{i,'z'}];
            a = [a;table_decay{i,'a'}];
            state = [state;table_decay{i,'stat'}];
            halflife_s = [halflife_s;table_decay{i,'halflife_s'}];
            branch = [branch;gammas(j,2)];
        end
    end
end
table_gamma = table(energy_MeV,radnuc,z,a,state,halflife_s,branch);

end % of the function

