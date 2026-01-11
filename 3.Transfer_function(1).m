%transfer function,传递函数，就是H(Z),分子项是零点，分母项是极点
%[b, a] = zp2tf(z, p, k)，b是传递函数分子多项式向量，a是传递函数分母多项式向量，z是零点向量，p是极点向量，k是系统的增益

%定义零点数组
z = [1.3*exp(1j*pi/3);1.3*exp(-1j*pi/3);1.1*exp(2*1j*pi/3);1.1*exp(-2*1j*pi/3);1;-1];%;号隔开为列向量
%定义极点数组
p = [0.7*exp(1j*pi/6),0.7*exp(-1j*pi/6),1*exp(1j*pi/4),1*exp(-1j*pi/4)];
%定义增益
k = 1;
%使用函数zp2tf,b是分子多项式，a是分母多项式
[b,a] = zp2tf(z,p,k);

disp(a);
disp(b);
