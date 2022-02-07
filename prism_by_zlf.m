clear;clc
tic
load('\PRISM\code_mat\H_Aspect_500m.mat');
% load('F:\CimissDownload\JX_19812010\pre_n.mat');
pre_n = xlsread('\PRISM\降水量81-20','统计结果');
aspect500 = importdata('\PRISM\aspect_500m.txt');
aspect87 = importdata('\PRISM\aspect_sta.txt');

%---去除验证站点-------
% pre_n(pre_n(:,1)==57799,:) = [];
% pre_n(pre_n(:,1)==58506,:) = [];
% pre_n(pre_n(:,1)==57894,:) = [];
% pre_n(pre_n(:,1)==58718,:) = [];
% pre_n(pre_n(:,1)==58612,:) = [];
% pre_n(pre_n(:,1)==58907,:) = [];
% pre_n(pre_n(:,1)==58617,:) = [];

Wd = zeros(length(HAspect500m),83);
Wz = zeros(length(HAspect500m),83);
for i = 1 : length(HAspect500m) 
    i
    for j = 1 : length(pre_n)
        if distance(pre_n(j,3),pre_n(j,2),HAspect500m(i,3),HAspect500m(i,2))*pi*6371000/180 <= 200000  %计算半径
            % 计算距离权重Wd
            if distance(pre_n(j,3),pre_n(j,2),HAspect500m(i,3),HAspect500m(i,2)) ~= 0
                Wd(i,j) = 1 / (distance(pre_n(j,3),pre_n(j,2),HAspect500m(i,3),HAspect500m(i,2))*pi*6371000/180)^2;
            else
                Wd(i,1) = 1;
            end
            % 计算高程权重Wz
            if abs(pre_n(j,4) - HAspect500m(i,4)) <= 100
                Wz(i,j) = 1 / 50;
            elseif abs(pre_n(j,4) - HAspect500m(i,4)) > 100 & abs(pre_n(j,4) - HAspect500m(i,4)) < 500
                Wz(i,j) = 1 / abs(pre_n(j,5) - HAspect500m(i,4));
            else
                Wz(i,j) = 0;
            end
        end
    end
end

save('wd04.mat','Wd');
save('wz04.mat','Wz');
toc


% %  方位角归类
% for i = 1 : length(aspect500.data)
%     if aspect500.data(i,3) > 0 & aspect500.data(i,3) <= 45
%         aspect500.data(i,3) = 1;
%     elseif aspect500.data(i,3) > 45 & aspect500.data(i,3) <= 90
%         aspect500.data(i,3) = 2;
%     elseif aspect500.data(i,3) > 90 & aspect500.data(i,3) <= 135
%         aspect500.data(i,3) = 3;
%     elseif aspect500.data(i,3) > 135 & aspect500.data(i,3) <= 180
%         aspect500.data(i,3) = 4;
%     elseif aspect500.data(i,3) > 180 & aspect500.data(i,3) <= 225
%         aspect500.data(i,3) = 5;
%     elseif aspect500.data(i,3) > 225 & aspect500.data(i,3) <= 270
%         aspect500.data(i,3) = 6;
%     elseif aspect500.data(i,3) > 270 & aspect500.data(i,3) <= 315
%         aspect500.data(i,3) = 7;
%     elseif aspect500.data(i,3) > 315 & aspect500.data(i,3) <= 360
%         aspect500.data(i,3) = 8;
%     end
% end
% for i = 1 : length(aspect87.data)
%     if aspect87.data(i,4) > 0 & aspect87.data(i,4) <= 45
%         aspect87.data(i,4) = 1;
%     elseif aspect87.data(i,4) > 45 & aspect87.data(i,4) <= 90
%         aspect87.data(i,4) = 2;
%     elseif aspect87.data(i,4) > 90 & aspect87.data(i,4) <= 135
%         aspect87.data(i,4) = 3;
%     elseif aspect87.data(i,4) > 135 & aspect87.data(i,4) <= 180
%         aspect87.data(i,4) = 4;
%     elseif aspect87.data(i,4) > 180 & aspect87.data(i,4) <= 225
%         aspect87.data(i,4) = 5;
%     elseif aspect87.data(i,4) > 225 & aspect87.data(i,4) <= 270
%         aspect87.data(i,4) = 6;
%     elseif aspect87.data(i,4) > 270 & aspect87.data(i,4) <= 315
%         aspect87.data(i,4) = 7;
%     elseif aspect87.data(i,4) > 315 & aspect87.data(i,4) <= 360
%         aspect87.data(i,4) = 8;
%     end
% end
%
% %赋予坡向权重
% for i = 1 : length(HAspect500m)
%     for j = 1 : length(pre_n)
%         if aspect500.data(i,3) == aspect87.data(j,4)
%             Wf(i,j) = 0.3;
%         elseif abs(aspect500.data(i,3) - aspect87.data(j,4)) == 1
%             Wf(i,j) = 0.15;
%         else
%             Wf(i,j) = 0.008;
%         end
%     end
% end
% toc


% load('\PRISM\wd.mat');
% load('\PRISM\wf01.mat');
% load('\PRISM\wz.mat');
%去7个除验证站
% Wd(:,12)=[];Wd(:,14)=[];Wd(:,25)=[];Wd(:,43)=[];Wd(:,46)=[];Wd(:,69)=[];Wd(:,77)=[];
% Wz(:,12)=[];Wz(:,14)=[];Wz(:,25)=[];Wz(:,43)=[];Wz(:,46)=[];Wz(:,69)=[];Wz(:,77)=[];

% w(:,:) = sqrt(0.8*Wd(:,:).^2 + 0.2*Wz(:,:).^2).*Wf(:,:);

%-----交叉验证---------
%1.寻找各个站点对应的格点位置

for i = 1:83
    juli(:,i) = distance([pre_n(i,3),pre_n(i,2)],[HAspect500m(:,3),HAspect500m(:,2)]);
end

%2.依次剔除站点后计算该位置预测值
tic

 for i = 1 : 83
    i
%     load('wd04.mat');
%     load('wz04.mat');
%     Wd(:,i) = [];
%     Wz(:,i) = [];
    w(:,:) = sqrt(0.8*Wd(:,:).^2 + 0.2*Wz(:,:).^2);
    w(isnan(w)) = 0;
    for j = 1 : length(HAspect500m)
        j
        sum1 = 0; sum2 = 0; sum3 = 0; sum4 = 0; sum5 = 0;
        for k = 1 : 83
            sum3 = w(j,k) * pre_n(k,4) + sum3; % wx
            sum4 = w(j,k) + sum4;              % w
            sum5 = w(j,k) * pre_n(k,18) + sum5; % wy
        end
         for k = 1 : 83
            sum1 = w(j,k) * (pre_n(k,4) - sum3/sum4) * (pre_n(k,18) - sum5/sum4) + sum1;
            sum2 = w(j,k) * (pre_n(k,4) - sum3/sum4)^2 + sum2;
        end
        Y(j,1) = sum1 / sum2 * (HAspect500m(j,4) - sum3/sum4) + sum5/sum4;
    end
    [a,r] = min(juli(:,i));
    yc(i,1) = Y(r,1);
 end

toc
%3.MAE和RMSE
%mae
sum = 0;
for i = 1:87
    sum = abs(yc(i,1)-pre_n(i,5))+sum;
end
mae = sum/87;
%rmse
sum = 0;
for i = 1:87
    sum = sum + (yc(i,1) - pre_n(i,5))^2;
end
rmse = sqrt(sum/87);

%----交叉验证结束--------
%----------

w(:,:) = sqrt(0.8*Wd(:,:).^2 + 0.2*Wz(:,:).^2);
w(isnan(w)) = 0;
mean_x = mean(pre_n(:,4));
mean_y = mean(pre_n(:,18));

for i = 1 : length(HAspect500m)
    sum1 = 0; sum2 = 0;sum3 = 0;sum4 = 0;sum5 = 0;
    for j = 1 : 83
        sum3 = w(i,j) * pre_n(j,4) + sum3; % wx
        sum4 = w(i,j) + sum4;              % w
        sum5 = w(i,j) * pre_n(j,18) + sum5;% wy
    end
    for j = 1 : 83
        sum1 = w(i,j) * (pre_n(j,4) - sum3/sum4) * (pre_n(j,18) - sum5/sum4) + sum1;
        sum2 = w(i,j) * (pre_n(j,4) - sum3/sum4)^2 + sum2;
    end
    Y(i,1) = sum1 / sum2 * (HAspect500m(i,4) - sum3/sum4) + sum5/sum4;
end

Y(Y(:,1) < 1300,1) = 1300;
Y(Y(:,1) > 2600,1) = 2600;

HAspect500m(:,6) = Y(:,1);
HAspect500m(isnan(HAspect500m(:,6)),:)=[];
dlmwrite('\PRISM\prism500m2021_1.txt',HAspect500m);

