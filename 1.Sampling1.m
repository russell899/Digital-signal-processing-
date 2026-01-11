f1 = 100;
u = 2000;
A = 0.25;
fs = 48000;
T=0:1/fs:8;

figure
%for fi=frequencies
    x = A*cos(pi*u*T*T+2*pi*f1*T);
    myspectrogram(x,fs/10,fs,hamming(fs/10),fs/20);
    pause
%end

function winHamming = hamming(N)

winHamming = 0.54-0.46*cos(2*pi*(0:N-1)/N);

end