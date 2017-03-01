%绘制可定位终端和基站的空间分布
clear all;
clc;

input_file = textread('D:\Question4\case026_input.txt');
mobile_location = textread('D:\Question4\location_output_case_026.txt');
mobile_located = textread('D:\Question4\result_case026.txt');

%基站数
base_num = input_file(1,1);
%终端数
mobile_num = input_file(2,1);

base_location = input_file(4:base_num + 3, 1:3);

%基站坐标
x_base = base_location(:,1);
y_base = base_location(:,2);
z_base = base_location(:,3);

%终端坐标
x_mobile = mobile_location(:,1);
y_mobile = mobile_location(:,2);
z_mobile = mobile_location(:,3);

%可被定位的终端数
located_num = mobile_located(1, 1);

%绘制基站的三维空间分布图
figure
subplot(1,2,1)
plot3(x_base, y_base, z_base, 'b*');
title('case026');
xlabel('x');
ylabel('y');
zlabel('z');

hold on
grid

for i = 1:located_num
    for j = 1:mobile_num
        if j == mobile_located(i,1)
            %绘制终端的三维空间分布图
            plot3(x_mobile(j), y_mobile(j), z_mobile(j), 'r*');
        end
    end
end

%绘制基站的二维空间分布图
subplot(1,2,2)
plot(x_base, y_base,'b*');
title('case026');
xlabel('x');
ylabel('y');

hold on
grid

for i = 1:located_num
    for j = 1:mobile_num
        if j == mobile_located(i,1)
            %绘制终端的二维空间分布图
            plot(x_mobile(j), y_mobile(j),'r*');
        end
    end
end