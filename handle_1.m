%% handle_1
clear;close all;
table_specimen = readtable('.\demo\ore-icp-ms.xlsx','Sheet','sheet1');
table_specimen = table_specimen(:,[1,5]);
table_gamma = tinaa(table_specimen,'tinaa-input.mat',[4500,66300,96840]);
table_gamma = sortrows(table_gamma,-8);
