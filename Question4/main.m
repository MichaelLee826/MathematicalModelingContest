%判断出可被定位的终端
clear all;
clc;

%根据需要修改文件路径及文件名
input_file = textread('D:\Question4\case026_input.txt');
mobile_location = textread('D:\Question4\location_output_case_026.txt');

%base_num为基站数，mobile_num为终端数
base_num = input_file(1,1);
mobile_num = input_file(2,1);

%基站坐标矩阵
base_location = input_file(4:base_num + 3, 1:3);

x_base = base_location(:,1);
y_base = base_location(:,2);
z_base = base_location(:,3);

x_mobile = mobile_location(:,1);
y_mobile = mobile_location(:,2);
z_mobile = mobile_location(:,3);

%可被定位的终端数
able = 0;
%不可被定位的终端数
unable = 0;
%如果可被定位，则这个终端对应的position为1；否则为0
position = zeros(mobile_num, 1);
%每个可被定位终端到基站之间的连接数矩阵
num = zeros(mobile_num, 1);

for i = 1:mobile_num
    %终端与基站之间的距离小于200米的个数
    counter = 0;
    for j = 1:base_num
        D= (x_mobile(i,1) - x_base(j,1))^2 + (y_mobile(i,1) - y_base(j,1))^2 + (z_mobile(i,1) - z_base(j,1))^2;
        %终端与各基站之间的距离
        d= sqrt(D);
        if d <= 200
            counter = counter + 1;
        end
    end
   
    if counter >= 4
       able = able + 1;
       position(i) = i;
       num(i) = counter;

    else
        unable = unable + 1;
        position(i) = 0;
    end
end

%所有可以被定位终端到基站之间的连接数
total_num = sum(num);
%连接度数
lambd = total_num / mobile_num;

%将结果写入文件中
file_result = fopen('D:\Question4\result_case026.txt', 'a');
fprintf(file_result, '%d   %d\n', able, unable);
fprintf(file_result, '%d\n', total_num);
fprintf(file_result, '%.2f\n',lambd);

for k = 1:mobile_num
    if position(k) > 0
        file_result = fopen('D:\Question4\result_case026.txt', 'a');
        fprintf(file_result, '%d    %d\n', k, num(k));
        fclose(file_result);
    end
end