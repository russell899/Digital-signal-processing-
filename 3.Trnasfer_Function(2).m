%impz函数的作用：从H(Z)得到h(z)

%定义零点数组
z = [1.3*exp(1j*pi/3);1.3*exp(-1j*pi/3);1.1*exp(2*1j*pi/3);1.1*exp(-2*1j*pi/3);1;-1];%;号隔开为列向量
%定义极点数组
p = [0.7*exp(1j*pi/6),0.7*exp(-1j*pi/6),1*exp(1j*pi/4),1*exp(-1j*pi/4)];
%定义增益
k = 1;
%使用函数zp2tf,b是分子多项式，a是分母多项式
[b,a] = zp2tf(z,p,k);

n = 50;                 % 样本点数

impz(b, a, n);
title('unit impluse reponse');
xlabel('samples');
ylabel('amp');
