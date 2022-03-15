function table_element = gen_table_element(sourceName,method)
% generate element table for code TINAA
% Input:
% sourceName: filename or path of the data containing all stable element
%    and their atom weight
% method: 1: read from https://www-nds.iaea.org/pgaa/databases.htm
%         2: read from database "nubase"
switch method
    case 1 % from https://www-nds.iaea.org/pgaa/databases.htm
        thistable = readtable(sourceName,'Sheet','import');
        table_element = thistable(:,1:3);
        table_element.Properties.RowNames = table_element.element;
        table_element = table_element(:,2:end);
        table_element = sortrows(table_element,1);
    case 2
        
    otherwise
        
        
end
end % of the function