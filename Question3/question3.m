clc;
clear all;

result1 = textread('D:\Question3\output_case_021.txt');
result2 = textread('D:\Question3\output_case_022.txt');
result3 = textread('D:\Question3\output_case_023.txt');
result4 = textread('D:\Question3\output_case_024.txt');
result5 = textread('D:\Question3\output_case_025.txt');

x1 = result1(:,1);
y1 = result1(:,2);
x2 = result2(:,1);
y2 = result2(:,2);
x3 = result3(:,1);
y3 = result3(:,2);
x4 = result4(:,1);
y4 = result4(:,2);
x5 = result5(:,1);
y5 = result5(:,2);

figure;
plot(x1, y1, '*');
figure;
plot(x2, y2, '*');
figure;
plot(x3, y3, '*');
figure;
plot(x4, y4, '*');
figure;
plot(x5, y5, '*');

num = 1000;%循环次数
for i=1:num
    a = unidrnd(1000,1,24); 
    b = sortrows(a');
    num_inliers = 0;%符合要求的点的数目
    max_inliers = 0;%拥有的最大数目
    index = b';%随机的24个值
    index_inliers = zeros(1,24);
    x = zeros(1,24); %随机选取的24个点
    y = zeros(1,24);
    for j=1:24
        x(1,j) = x5(index(1,j),1);
        y(1,j) = y5(index(1,j),1);
    end
    paras = polyfit(x,y,2);
    max_paras = zeros(1,3);
    a1 = paras(1,1);
    a2 = paras(1,2);
    a3 = paras(1,3);
    
    for m=1:1000
        x_d = -600:0.1:300;
        f = a1*x_d.^2+a2*x_d+a3;
        for k=1:length(x_d);
            den(k) = sqrt((x_d(k)-x5(m,1))^2+(f(k)-y5(m,1))^2);
        end
        erro = min(den);
        if erro<10
            num_inliers = num_inliers+1;
            %index_inliers = index;
        end
    end
    if num_inliers>max_inliers
        max_inliers = num_inliers;
        max_paras = paras;
        index_inliers = index;
    else
        break
    end
end





