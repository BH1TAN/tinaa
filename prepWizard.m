%% prepWizard
% Preparing the tallys (tables) for element, isotope, decay, gamma datas
% the stage of code TINAA is built here
clear;close all;

%%
% table_element contains all the elements no matter it is stable or not
table_element = gen_table_element('.\naa-database\element.xls',1);
disp('Success: Prepared table_elements');

%%
table_isotope = gen_table_isotope('.\naa-database\isotope.xls',1);
disp('Success: Prepared table_isotopes');

%%
load('package_spec_neutron_withoutCd','spec_neutron');
table_active = gen_table_active(table_isotope,'.\xs_n_gamma',spec_neutron,1);
disp('Success: Prepared table_active');

%%
table_decay = gen_table_decay(table_active,1);
disp('Success: Prepared table_decay');

table_gamma = gen_table_gamma('.\decay_gamma',table_decay);

save('tinaa-input.mat');