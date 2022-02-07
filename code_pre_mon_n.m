clear
clc

pre = xlsread('\PRISM\��ˮ��81-20.xls','20_20');

%% �����վ��ȱ����
count_9999 = zeros(1,84);
for i = 1 : length(pre)
    for j = 2 : 84
        if pre(i,j)>=9999
            count_9999(1,j) = count_9999(1,j) + 1;
            pre(i,j) = 0;
        end
    end
end

%% �����վ���½�ˮ

pre_mon_n = zeros(13,83);
date_str = num2str(pre(:,1));
for i = 1 : length(pre)
    for j  = 1 : 12
        if j <10
            if strcmp(date_str(i,5:6),['0',num2str(j)])
                pre_mon_n(j,:) = pre_mon_n(j,:) + pre(i,2:84);
            end
        else
            if strcmp(date_str(i,5:6),num2str(j))
                pre_mon_n(j,:) = pre_mon_n(j,:) + pre(i,2:84);
            end
        end
    end
end
pre_mon_n(13,:)= sum(pre_mon_n(1:12,:));
pre_mon_n = [pre_mon_n/40]';% ��վ1981-2020�����º��꽵ˮ��