%将不可定位终端坐标修改为xnan ynan znan
clc;
clear all;

%根据需要修改文件路径及文件名
mobile_location = textread('D:\Question4\location_output_case_026.txt');
mobile_located = textread('D:\Question4\result_case026.txt');

%可被定位的终端数
located_num = mobile_located(1, 1);

%终端三维坐标矩阵的行数和列数
[row, col] = size(mobile_location);

%转换为cell数组
cell_mobile_location = cell(row, col);
for i = 1:row
    for j = 1:col
        cell_mobile_location{i, j} = mobile_location(i, j);
    end
end

%matrix第一列为可被定位的终端数标号，第二列为该终端的连接数
matrix = mobile_located(4:located_num + 3, :);

cursor = 1;
for i = 1:row
    if cursor <= located_num
       num = matrix(cursor,1);
       if i == num
            cursor = cursor + 1;
       else
            cell_mobile_location{i, 1} = 'xnan';
            cell_mobile_location{i, 2} = 'ynan';
            cell_mobile_location{i, 3} = 'znan';
       end 
    else
        if i <= row
           for j = i:row
               cell_mobile_location{j, 1} = 'xnan';
               cell_mobile_location{j, 2} = 'ynan';
               cell_mobile_location{j, 3} = 'znan';
               
               %将结果写入文件中
               file_result = fopen('D:\Question4\output_case_026.txt', 'a');
               if strcmp(cell_mobile_location{i, 1}, 'xnan')
                    fprintf(file_result, '%-7s %-7s %-7s\n', cell_mobile_location{i, 1}, cell_mobile_location{i, 2}, cell_mobile_location{i, 3});
               else
                    fprintf(file_result, '%-7.2f %-7.2f %-7.2f\n', cell_mobile_location{i, 1}, cell_mobile_location{i, 2}, cell_mobile_location{i, 3});
               end
               fclose(file_result);
           end
        end
        break;
    end
    
    %将结果写入文件中
    file_result = fopen('D:\Question4\output_case_026.txt', 'a');
    if strcmp(cell_mobile_location{i, 1}, 'xnan')
        fprintf(file_result, '%-7s %-7s %-7s\n', cell_mobile_location{i, 1}, cell_mobile_location{i, 2}, cell_mobile_location{i, 3});
    else
        fprintf(file_result, '%-7.2f %-7.2f %-7.2f\n', cell_mobile_location{i, 1}, cell_mobile_location{i, 2}, cell_mobile_location{i, 3});
    end
    fclose(file_result);
end

