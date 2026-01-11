%第二个图的单位冲即激响应
zero2 = [1;-1];%;号隔开为列向量
%定义极点数组
pole2 = [1*exp(1j*pi/4),1*exp(-1j*pi/4)];
%定义增益
k = 1;
%使用函数zp2tf,b是分子多项式，a是分母多项式
[d,c] = zp2tf(zero2,pole2,k);

n = 50;                 % 样本点数
impz(d, c, n);
title('b的单位冲激响应');
xlabel('样本点');
ylabel('幅值');