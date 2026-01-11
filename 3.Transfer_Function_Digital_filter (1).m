%b是分子多项式
b = 1;
%a是分母多项式
a = [1,0.1929,0.9861,-0.2393,0.4408,-0.1956,0.1139];

%画出这个传递函数的零点与极点
freqz(b, a);
title('Frequency Response');%判断是滤波器的类型，看幅值那张图

figure;
zplane(b, a);
title('Pole-Zero Plot');
