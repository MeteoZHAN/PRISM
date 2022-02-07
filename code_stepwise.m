clear
clc

pre = xlsread('降水量81-20.xls','统计结果');

stepwise(pre(:,2:4),pre(:,18));
