function table_isotope = gen_table_isotope(sourceName,method)
% generate isotope table for code TINAA
% Input:
% sourceName: filename or path of the data containing all stable isotopes
%    and their abundance
% method: 1: read from https://www-nds.iaea.org/pgaa/databases.htm
%         2: read from database "nubase"
switch method
    case 1 % from https://www-nds.iaea.org/pgaa/databases.htm
        thistable = readtable(sourceName,'Sheet','import');
        table_isotope = thistable(:,2:5);
        rowNames = cell(size(table_isotope,1),1);
        for i = 1:size(table_isotope,1)
            thisIso = table_isotope{i,1}{1,1};
            rowNames{i,1} = [thisIso(isstrprop(thisIso,'alpha')),thisIso(isstrprop(thisIso,'digit'))];
        end
        table_isotope = table_isotope(:,2:end);
        table_isotope.Properties.RowNames = rowNames;
    case 2
        
    otherwise
        
        
end % of switch
end % of the function

