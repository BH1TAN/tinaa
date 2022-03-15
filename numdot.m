function [intint,xss,spee] = numdot(spe,xs,plotOrNot)
% 旧函数 specialdotnew2(spe,xs,plotOrNot)
% 计算注量率直方图与截面曲线的乘积
% 注意：仅验证了适用于中子活化Au的计算，能谱和截面数据点间隔都较均匀
%       中子活化其它核素的计算需注意数据点是否均匀
% 注意：光子活化过程能谱数据点和截面数据点一般不均匀且不一致,尚未验证本函数可用性
% Input：
% spe 射线能谱,第一列能量，第二列通量
% xs  (n,g)截面，第一列能量，第二列截面；第一列的单位需和spe第一列一致
% Output:
% intint(1): 截面与注量的数值积分
% spee 调试用，射线能谱,第一列能量，第二列通量,第三列该bin内的平均截面
% xss  调试用，(n,g)截面，第一列能量，第二列截面，第三列注量率密度
intint = [];
xss = [];spee=[];
if max(spe(:,1))<min(xs(:,1)) ||min(spe(:,1))>max(xs(:,1))
    return;
end
xs = [0,0;xs];[~,dd]=unique(xs(:,1));xs = xs(dd,:); % 删除xs重复行
spe = [0,0;spe];
xs(:,3) = interp1(spe(:,1),spe(:,2),xs(:,1)); % 在截面点内插注量率作为权重
for i = 2:size(spe,1)
    thisXs = xs(find(xs(:,1)<=spe(i,1)),:);
    thisXs = thisXs(find(thisXs(:,1)>spe(i-1,1)),:);
    spe(i,3) = thisXs(:,2)'*thisXs(:,3)/sum(thisXs(:,3)); % Energybin的平均截面
end
spe(isnan(spe))=0;
xss = xs; 
spee = spe;
intint(1) = spe(:,2)'*spe(:,3);
if plotOrNot
    figure;
    yyaxis left
    semilogx(spe(:,1),spe(:,2),'b.-');hold on;
    xlabel('Energy');
    ylabel('Ray intensity');
    yyaxis right
    loglog(xs(:,1),xs(:,2),'r.-');
    loglog(spe(:,1),spe(:,3),'g.-');
    ylabel('Cross section (b)');
    title(['Total integration:',num2str(intint(1))]);
    legend({'Intensity','Cross section','Mean cross section'});
end
end
