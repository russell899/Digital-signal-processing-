%b是分子多项式
b = 1;
%a是分母多项式
a = [1,0.1929,0.9861,-0.2393,0.4408,-0.1956,0.1139];

%绘制该系统的冲激函数
n = 50; %样本点数
impz(b,a,n);
title('impulse response');
xlabel('samples');
ylabel('amp');
