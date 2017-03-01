%目标函数
function f = obj_fun(input_file, base_num, mobile_num, row, x);
    
    %base为30个基站坐标，time为终端到基站的传播时间
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
    %目标函数中x(1)-x(5)所表示的变量
    % a->x(1)
    % b->x(2)
    % x->x(3)
    % y->x(4)
    % z->x(5)

    %f为目标函数
    f = 0;
    
    %找出半径最接近的三个球
    i = 0;
    j = 0;
    k = 0;
    
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
    
    %得到目标函数
    for i = 1:3
        r = R(i);
        x1 = X(i);
        y1 = Y(i);
        z1 = Z(i);
        f = f - x(1) * ((x(3) - x1)^2 + (x(4) - y1)^2) - x(2) * (x(5) - z1)^2 + r^2;
    end
end