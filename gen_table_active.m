function table_active = gen_table_active(table_isotope,sourceName,spec_neutron,method)
% generate isotope table for code TINAA
% Input:
% table_isotope: produced by prepWizard.m
% sourceName: filename or path of the cross sections
% neutronSpec: neutron flux spec with units MeV and nv
% method: 1: using NJOY21 produced (n,g) cross sections
%
% todo: Modify this function if (g,n),(g,p) and other reactions needs
% to be considered
%
spec_neutron = [spec_neutron(:,1)*1e6,spec_neutron(:,2)]; % units to eV
table_active = table_isotope;
table_active{:,'int_evb'}=0;
table_active{:,'a'} = table_active{:,'a'}+1;
switch method
    case 1
        %% calculate integral
        disp('Calculating the integral(int_evb) of table_active');
        for i = 1:size(table_active,1) % Each isotope
            xs = readtable([sourceName,'\',table_active.Properties.RowNames{i},'.txt']);
            xs = table2array(xs);
            if isempty(xs)
                table_active{i,'int_evb'} = 0;
            else
                table_active{i,'int_evb'} = numdot(spec_neutron,xs,0);
            end
            processbar(i,size(table_active,1),10);
        end
        %% fill in probmeta
        disp('Fill in the probmeta of table_active');
        [table_active] = compoundNuc(table_active,spec_neutron);
    case 2
        
    otherwise
        
end

