%% 准备计算所需的核数据
clear;close all;

%% 原子数表 list_sample_element
file = 'demo\ore-icp-ms.xlsx';
list_sample_element_origin = readtable(file,'Sheet','sheet1');
list_sample_element = list_sample_element_origin(:,[1,2]);
list_sample_element.Properties.RowNames = list_sample_element.Element;
disp('Success: Get list_isotope');

%% 同位素丰度表 list_abundance
% 尚未完成使用定制丰度的代码
% xls from https://www-nds.iaea.org/pgaa/iaeapgaa.htm
file = 'naa-database\isotope.xls';
list_isotope = readtable(file,'Sheet','for import');
disp('Success: Get list_abundance');

%% 中子俘获截面库 
% output: struct 'xs_ng',example: xs_ng.Ag107;xs_ng.Ag109
%         first column: energy(MeV)
%         second column: cross section (b)
path_ng = 'xs_n_gamma';
dir1 = dir(path_ng);
for i = 3:length(dir1)
    thisName = dir1(i).name(1:end-4);
    thisXs = importdata([dir1(i).folder,'\',dir1(i).name]);
    if isfield(thisXs,'data')
    eval(['xs_ng.',thisName,'=thisXs.data;']);
    else
        disp(['Warning: Could not read neutron xs for ',thisName]);
    end
end
disp('Success: Get xs_ng');

%% 缓发伽马库 decayGamma
file = 'naa-database\decaygammas.xls';
list_decay = readtable(file,'Sheet','for import');
t=list_decay(:,[1,2,3,7]);t=unique(t);
disp('Following compond nucleus have metastable state(s),see list_meta:');
list_meta = cell(0,0);
for i = 2:size(t,1)
    if t.A(i)==t.A(i-1)
        disp(t.Isotope{i});
        list_meta = [list_meta;{t.Isotope{i},t.Halflife(i)}];
    end
end
disp('Success: Get decayGamma database');

%% 保存
save('package_sample','list_sample_element');
save('package_nuclear','list_isotope','xs_ng','list_decay');
