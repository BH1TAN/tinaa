%% 准备计算所需的核数据
clear;close all;

%% 原子数表 list_sample_element
file = 'E:\工作区\0资料大全\金矿\金矿成分ICPMS分析-清析-与澳大利亚结果不符\20210409ICPMS检测报告\检测报告.xlsx';
list_sample_element_origin = readtable(file,'Sheet','质量占比');
list_sample_element = list_sample_element_origin(:,[1,2]);
list_sample_element.Properties.RowNames = list_sample_element.Element;
disp('Success: Get list_isotope');

%% 同位素丰度表 list_abundance
% 尚未完成使用定制丰度的代码
% xls from https://www-nds.iaea.org/pgaa/iaeapgaa.htm
file = 'E:\myDataBase\NAA-database\isotope.xls';
list_isotope = readtable(file,'Sheet','for import');
disp('Success: Get list_abundance');

%% 中子俘获截面库 
% output: struct 'xs_ng',example: xs_ng.Ag107;xs_ng.Ag109
%         first column: energy(MeV)
%         second column: cross section (b)
path_ng = 'E:\myDataBase\TINAA-simulation-tool\xs_n_gamma';
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
file = 'E:\myDataBase\NAA-database\decaygammas.xls';
list_decay = readtable(file,'Sheet','Decay');

%% 保存
save('package_sample','list_sample_element');
save('package_nuclear','list_isotope','xs_ng');