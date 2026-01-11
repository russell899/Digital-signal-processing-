% Parameters for chirp signal
A = 0.25;             % Amplitude
f1 = 100;             % Start frequency (Hz)
mu = 2000;            % Chirp rate (Hz^2)
fs = 16000;           % Sampling frequency (Hz)
duration = 8;         % Duration (seconds)

% Generate time vector and chirp signal
t = 0:1/fs:duration-1/fs;
y = A * cos(pi * mu * t.^2 + 2 * pi * f1 * t);

% Plot the time-domain signal (optional)
figure;
plot(t(1:2000), y(1:2000)); % Plot the first few samples
title('Chirp Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Spectrogram parameters for myspectrogram
nfft = 1024;                   % FFT size
window = hamming(512);          % Hamming window of length 512
noverlap = 256;                 % 50% overlap
doplot = 1;                     % Plot the spectrogram
dbdown = 100;                   % Clip below this dB level

% Generate and plot the spectrogram using myspectrogram
myspectrogram(y, nfft, fs, window, noverlap, doplot, dbdown);

% Play the chirp signal
sound(y, fs);


function winHamming = hamming(N)

winHamming = 0.54-0.46*cos(2*pi*(0:N-1)/N);

end