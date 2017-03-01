%计算终端位置坐标，输出文件名与前三问不同
function f = Question4_1;
    clear all;
    clc;

    %根据需要修改文件路径及文件名
    input_file = textread('D:\Question4\case026_input.txt');
    
    base_num = input_file(1,1);
    mobile_num = input_file(2,1);

    %base为基站坐标，time为终端到基站的传播时间
    base = input_file(4 : base_num + 3, 1:3);
    time = input_file(base_num + 4 : base_num + mobile_num + 3, 1:base_num);
    %answer = answer_file(1:1100, 1:3);

    % 光的传播速度
    global SPD;
    SPD = 3e8;

    %基站的X轴坐标矩阵
    axis_x = base(:,1);
    %基站的Y轴坐标矩阵
    axis_y = base(:,2);
    %基站的Z轴坐标矩阵
    axis_z = base(:,3);

    % figure
    % plot(axis_x, axis_y, '*');
    % hold on
    % grid

    %距离矩阵，第i行为第i个终端到第N个基站的距离
    distance = SPD * time; 

    for row = 1:mobile_num
        %第row行终端到基站距离（已排序）
        radia = distance(row,:);
        radia_n = sort(radia);

        axis_x_n = ones(base_num,1);
        axis_y_n = ones(base_num,1);
        axis_z_n = ones(base_num,1);

    for i = 1:base_num
        for j = 1:base_num
            if radia_n(1,i) ==  radia(1,j)
                axis_x_n(i,1) = axis_x(j,1);
                axis_y_n(i,1) = axis_y(j,1);
                axis_z_n(i,1) = axis_z(j,1);
            end
        end
    end
    
    %x、y、z的下边界
    x_lb = axis_x_n(1,1) - radia_n(1,1);
    y_lb = axis_y_n(1,1) - radia_n(1,1);
    z_lb = 1;
    
    %x、y、z的上边界
    x_ub = axis_x_n(1,1) + radia_n(1,1);
    y_ub = axis_y_n(1,1) + radia_n(1,1);
    z_ub = 2;
    
    %非线性规划
    [coordinate, value] = fmincon(@(x)obj_fun(input_file, base_num, mobile_num, row, x), [2; 3; x_ub; y_ub; z_ub], [], [], [], [], [0; 0; x_lb; y_lb; z_lb], [100; 1000; x_ub; y_ub; z_ub], @(x)nonlcon_fuc(input_file, base_num, mobile_num, row, x))
    
    %x、y、z的结果
    x_result = coordinate(3,1);
    y_result = coordinate(4,1);
    z_result = coordinate(5,1);
    
    %将结果写入到文件中
    file_result = fopen('D:\Question4\output_case_026.txt', 'a');
    fprintf(file_result, '%7.2f %7.2f %5.2f\n', x_result, y_result, z_result);
    fclose(file_result);
    
    end
end