parallel_scheme = bpf2 + bpf3;
%fs = 24000;
%l = length(c);
%n = (0:l-1)/fs;
plot(parallel_scheme);%如果不指定时间轴，就会是索引形式
title('impulse reponse of parallel scheme');
xlabel('samples');
ylabel('Amplitude');
fvtool(parallel_scheme,[1]);