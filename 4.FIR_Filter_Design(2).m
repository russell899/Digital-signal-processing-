c = conv(bsf1,bpf1);
%fs = 24000;
%l = length(c);
%n = (0:l-1)/fs;
plot(c);%如果不指定时间轴，就会是索引形式
title('impulse reponse of cascade scheme');
xlabel('samples');
ylabel('Amplitude')
fvtool(c,[1],'Analysis', 'freq');%第一个参数是分子系数，第二个参数是分母系数