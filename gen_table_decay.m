function table_decay = gen_table_decay(table_active,method)
% Read radioactive isotopes from table_active, then fill in their
% halflife and partial integral int_part
% Input:
% sourceName: filename or path of the data containing decay isotopes
% table_active: table containing radioactive isotopes
% method: 1: read from https://www-nds.iaea.org/pgaa/databases.htm
%         2: read from database "nubase"
%
rowNames = cell(0,0);
z = [];
a = [];
stat = cell(0,0);
int_part = [];
disp('Storing the decay parameters of table_decay');
switch method
    case 1 % using table_active
        for i = 1:size(table_active,1)
            for j = 1:3
                thisCompound=table_active{i,'compound'}{1,j};
                if isempty(thisCompound)
                    break;
                else
                    rowNames = [rowNames;thisCompound];
                    z = [z;table_active{i,'z'}];
                    a = [a;table_active{i,'a'}];
                    switch j
                        case 1
                            stat = [stat;'g'];
                        case 2
                            stat = [stat;'m'];
                        case 3
                            stat = [stat;'n'];
                    end
                    %                     halflife_s = [halflife_s; ...
                    %                         gethalflife(table_active{i,'z'},table_active{i,'a'},stat{end,1})];
                    int_part = [int_part; ...
                        table_active{i,'int_evb'}*table_active{i,'probmeta'}(1,j)];
                end
            end
        end
        halflife_s = zeros(size(z,1),1);
        table_decay = table(z,a,stat,halflife_s,int_part);
        table_decay.Properties.RowNames = rowNames;
        for i = 1:size(table_decay,1)
            processbar(i,size(table_decay,1),10);
            table_decay{i,'halflife_s'} = ...
                gethalflife(table_decay{i,'z'},table_decay{i,'a'},stat{i,1});
        end
        content = find(~~table_decay{:,'halflife_s'} & ~~table_decay{:,'int_part'});
        table_decay = table_decay(content,:);
    case 2
        
    otherwise
        
        
end % of switch
end % of the function

