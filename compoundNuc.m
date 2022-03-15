function [outTable] = compoundNuc(inTable,spec_neutron)
% Generate compound nucleus list of reaction
% Input:
%    target: target nucleus. ('23Na');
%    spec_neutron: MeV and nv
% Output:
%    nuc: radioactive nucleus
%    prob: probability to form this radioactive nucleus
% Todo:
%    The probablity of producing different compound nucleus may depends on
%    the spec_neutron. But, it is not taken into consideration now.

outTable = inTable;
outTable{1,'compound'}=cell(1,3);
isomer = readtable('.\isomer\isomer_ng.xlsx','Sheet','Sheet1');
isomer = isomer(:,1:4);
isomer.Properties.RowNames = isomer{:,'target'};
list_isomer = table2cell(isomer(:,1));
isomer = isomer(:,2:end);
for i = 1:size(inTable,1)
    thisTarget = inTable.Properties.RowNames{i};
    thisName = thisTarget(isstrprop(thisTarget,'alpha'));
    thisA = str2num(thisTarget(isstrprop(thisTarget,'digit')));
    if ismember(thisTarget,list_isomer) % exist isomer
        outTable{i,'probmeta'} = isomer{thisTarget,:};
        if strcmp(thisTarget,'In115')
            outTable{i,'compound'} = {'In116','In116m','In116n'};
        elseif strcmp(thisTarget,'Sb123')
            outTable{i,'compound'} = {'Sb124','Sb124m','Sb124n'};
        elseif strcmp(thisTarget,'Eu151')
            outTable{i,'compound'} = {'Eu152','Eu152m','Eu152n'};
        else
            outTable{i,'compound'} = {[thisName,num2str(thisA+1)],[thisName,num2str(thisA+1),'m'],[]};
        end
    else % do not exist isomer
        outTable{i,'probmeta'} = [1,0,0];
        outTable{i,'compound'} = {[thisName,num2str(thisA+1)],'',''};
        
    end
end
end % of the function

