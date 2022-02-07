clear
clc

data = xlsread('\PRISM\Papers\交叉验证.xlsx','交叉验证');
% 
% figure(1)
% bar(data(1:12,1:4))
% xticks(1:12)
% xticklabels({'1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'})
% ylabel(['\fontname{Times new roman} RMSE(mm)'])
% legend({'IDW','OK','MLR','PRISM'},'Location','northeast')

figure(2)
bar(data(13,1:4))
xticks(1:4)
xticklabels({'IDW','OK','MLR','PRISM'})
ylabel(['\fontname{Times new roman} RMSE(mm)'])
legend({'IDW','OK','MLR','PRISM'},'Location','northeast')

figure(1)
bar(data(1:13,1:4))
xticks(1:13)
xticklabels({'1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','年'})
ylabel(['\fontname{Times new roman} RMSE(mm)'])
legend({'IDW','OK','MLR','PRISM'},'Location','northwest')


% fig = figure;
% left_color = [0 0 0];
% right_color = [0 0 0];
% set(fig,'defaultAxesColorOrder',[left_color; right_color]);
% yyaxis left  % 激活左坐标
% bar(1:13,data(1:13,1:4)) % 逐月RMSE
% ylabel(['\fontname{宋体}各月降水量\fontname{Times new roman} RMSE(mm)'])
% hold on
% yyaxis right  %激活右坐标
% bar(13:14,data(13:14,1:4)) % 年RMSE
% ylabel(['\fontname{宋体}年平均降水量\fontname{Times new roman} RMSE(mm)'])
% xticks(1:13)
% xticklabels({'1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月','全年'})



pre4_n = [1727.17	1695.442498	1859.095	1884.474998	1619.117498	1578.315	1930.8825	2041.5;
1711.43	1673.23	1693.24	1771.97	1570.82	1569.23	1572.61	1460.63;
1696.77	1695.09	1747.93	1785.05	1581.64	1571.45	1547.9	1495;
1710.57397	1635.727205	1887.803299	1762.67676	1664.514378	1608.68393	1811.853914	2100.940176;
1678.818876	1660.315077	1849.525633	1822.033898	1595.315435	1590.862411	2004.42747	2021.03186];
figure(3)
plot(1:8,pre4_n(1,1:8),'k--','linewidth',1)
hold on
plot(1:8,pre4_n(2,1:8),'k-s','linewidth',1)
plot(1:8,pre4_n(3,1:8),'k-o','linewidth',1)
plot(1:8,pre4_n(4,1:8),'k-^','linewidth',1)
plot(1:8,pre4_n(5,1:8),'k-*','linewidth',1)
xlabel('站名')
ylabel(['\fontname{宋体}降水量\fontname{Times new roman} (mm)'])
xticks(1:8)
xticklabels({'余干','丰城','玉山','金溪','寻乌','安远','井冈山','庐山'})
legend({'观测值','IDW','OK','MLR','PRISM'},'Location','northwest')





clear;
close all;
data=[40 9];
bar(data,1);
title('Hello world','FontName','Times New Roman','FontSize',15);   %图名
xlabel('Hey girl','fontsize',15,'FontName','Times New Roman');     %横坐标内容及字体
ylabel('Hey man','fontsize',15,'FontName','Times New Roman');      %纵坐标内容及字体
axis([0 4 0 50]);                                   %修改横坐标范围
legend('AA','BB','Square');                         %修改图例
set(gca,'XTickLabel',{'Img1','Img2','Img3'},'FontSize',15,'FontName','Times New Roman');    %修改横坐标名称、字体
applyhatch(gcf,'\');                             %设置阴影格式'/', '\', '|', '-', '+', 'x', '.'






