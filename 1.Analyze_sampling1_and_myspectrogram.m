frequencies=1000:1000:7000; %to create a frenquency vector start from 1000 and end at 7000hz,the step is 1000hz
fs=8000; %sampling rate is at 8000hz
T=0:1/fs:2; %generate a time vector from 0s to 2s. the step of it is 1/fs

figure % create a new window
for fi=frequencies %create a loop,the loop is from 1000hz to 7000hz
x = 0.25*sin(2*pi*fi*T);%the signal which will be sampled at this question
myspectrogram(x,fs/10,fs,hamming(fs/10),fs/20);
pause
end

%define hamming window,hamming window is used to signal process
function winHamming = hamming(N) %define a new function and there is parameter of this function,N is the legenth of this window

winHamming = 0.54-0.46*cos(2*pi*(0:N-1)/N);

End
