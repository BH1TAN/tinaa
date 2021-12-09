%% TINAA main
clear;close all;
load('package_sample.mat');
load('package_nuclear.mat');

%% 制作样品的原子数量表 list_sample_isotope
list_main = list_isotope;
for i = 1:size(list_main,1)
    thisIsotope = list_main{i,'Element'};
    try
    list_main.amount(i) = list_main{i,'Abundance'}/100* ...
        list_sample_element{thisIsotope,2};
    catch 
        list_main.amount(i) = 0;
    end
end
toDelete = list_main.amount<1e-40;
list_main(toDelete,:)=[];

%% 制作分核素能谱 

