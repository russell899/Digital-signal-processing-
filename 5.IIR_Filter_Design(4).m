[y,fs] = audioread('speech_female.wav');

load('second_filter_coefficients.mat');

filtered_signal_second = filter(second_filter_coefficienta,y);


subplot(2,1,1);
spectrogram(y,1024,768,2048,32000,'yaxis');%signal;window's length;overlap between window;FFt size;sample rates;set frequency as yaxis
caxis([-90 -20]);%set the color between -90 to -20


subplot(2,1,2);
spectrogram(filtered_signal_second,1024,768,2048,32000,'yaxis');
caxis([-90 -20]);%set the color between -90 to -20