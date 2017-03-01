%绘制折线程序

clear all;
clc;

mobile_num = [1000, 1100, 1200, 1300, 1400];
lambd = [2.52, 0.84, 5.58, 5.07, 9.45];
located_num = [438, 179, 766, 779, 978];
connected_num = [2515, 921, 6701, 6592, 13224];

subplot(1,3,1);
plot(mobile_num, lambd,'b-*');
xlabel('终端数');
ylabel('连接度数');
grid

subplot(1,3,2)
plot(mobile_num, located_num,'r-*');
xlabel('终端数');
ylabel('可被定位终端数');
grid

subplot(1,3,3)
plot(mobile_num, connected_num,'g-*');
xlabel('终端数');
ylabel('连接数');
grid