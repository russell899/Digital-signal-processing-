%第三个图的单位冲即激响应
zero3 = [0;0];%;号隔开为列向量
%定义极点数组
pole3 = [1;1];
%定义增益
k = 1;
%使用函数zp2tf,b是分子多项式，a是分母多项式
[b,a] = zp2tf(zero3,pole3,k);
disp(b)
disp(a)

n = 50;                 % 样本点数
impz(b, a, n);
title('c的单位冲激响应');
xlabel('样本点');
ylabel('幅值');