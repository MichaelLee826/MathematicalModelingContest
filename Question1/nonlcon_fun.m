%非线性约束条件
function [g,h] = nonlcon_fuc(input_file, base_num, mobile_num, row, x);

    %base为30个基站坐标，time为终端到基站的TOA
    base = input_file(4 : base_num + 3, 1:3);
    time = input_file(base_num + 4 : base_num + mobile_num + 3, 1:base_num);

    % 无线电信号的传播速度
    SPD = 3e8;

    %基站的X轴坐标矩阵
    axis_x = base(:,1);
    %基站的Y轴坐标矩阵
    axis_y = base(:,2);
    %基站的Z轴坐标矩阵
    axis_z = base(:,3);

    %距离矩阵，第i行为第i个终端到各个基站的距离
    distance = SPD * time; 

    %第row个终端到基站距离
    radia = distance(row,:);

    %按照半径，由小到大排序
    radia_n = sort(radia);

    %排序后的给基站三维坐标
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

    %半径最小球的的基站坐标
    x_min1 = axis_x_n(1,1);
    y_min1 = axis_y_n(1,1);
    z_min1 = axis_z_n(1,1);

    %半径次小球的的基站坐标
    x_min2 = axis_x_n(2,1);
    y_min2 = axis_y_n(2,1);
    z_min2 = axis_z_n(2,1);

    %最小的两个半径
    r_min1 = radia_n(1,1);
    r_min2 = radia_n(1,2);

    i = 0;
    j = 0;
    k = 0;
    
    %找出半径最接近的三个球
    for num = 1:base_num - 2
        if ((radia_n(1, num + 1) - radia_n(1, num)) < 20)  && ((radia_n(1, num + 2) - radia_n(1, num + 1)) < 20)
                i = num;
                j = num + 1;
                k = num + 2;
                break;
        else
            i = 2;
            j = 3;
            k = 4;
        end
    end
    
    R = [radia_n(1,i), radia_n(1,j), radia_n(1,k)];
    X = [axis_x_n(i,1), axis_x_n(j,1) , axis_x_n(k,1)];
    Y = [axis_y_n(i,1), axis_y_n(j,1) , axis_y_n(k,1)];
    Z = [axis_z_n(i,1), axis_z_n(j,1) , axis_z_n(k,1)];

    %g和h为非线性规划中的非线性约束条件
    g=[(x(3) - x_min1)^2 + (x(4) - y_min1)^2 + (x(5) - z_min1)^2 - r_min1^2
       (x(3) - x_min2)^2 + (x(4) - y_min2)^2 + (x(5) - z_min2)^2 - r_min2^2
       - R(1)^2 + x(1) * ((x(3) - X(1))^2 + (x(4) - Y(1))^2) + x(2) * (x(5) - Z(1))^2
       - R(2)^2 + x(1) * ((x(3) - X(2))^2 + (x(4) - Y(2))^2) + x(2) * (x(5) - Z(2))^2
       - R(3)^2 + x(1) * ((x(3) - X(3))^2 + (x(4) - Y(3))^2) + x(2) * (x(5) - Z(3))^2
         ];
     
     h=[];
end