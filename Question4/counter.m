%统计连接数大于等于6个的终端
clc
clear all

%根据需要修改文件路径及文件名
mobile_located = textread('D:\Question4\result_case026.txt');

%可被定位的终端数
located_num = mobile_located(1, 1)

%所有可被定位的终端标号及其连接数矩阵
num = mobile_located(4:located_num + 3, 2);

%计数：统计连接数大于等于6个的终端
counter = 0;
for i = 1:located_num
    if num(i) >= 6
        counter = counter + 1;
    end
end

%将结果写入文件
file_result = fopen('D:\Question4\counter_case030.txt', 'a');
fprintf(file_result, '%d\n', counter);
fclose(file_result);