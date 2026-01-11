% Load the audio files
[maleVoice, Fs_male] = audioread('m1.wav'); % Male voice
[femaleVoice, Fs_female] = audioread('f1.wav'); % Female voice

% Compute the autocorrelation for male voice
[auto_corr_male, lags_male] = xcorr(maleVoice, 'coeff');

% Compute the autocorrelation for female voice
[auto_corr_female, lags_female] = xcorr(femaleVoice, 'coeff');


% Plot the autocorrelation for male voice
figure;
subplot(2, 1, 1);
plot(lags_male / Fs_male, auto_corr_male);
xlabel('Lag (s)');
ylabel('Autocorrelation');
title('Autocorrelation of Male Voice');
grid on;

% Plot the autocorrelation for female voice
subplot(2, 1, 2);
plot(lags_female / Fs_female, auto_corr_female);
xlabel('Lag (s)');
ylabel('Autocorrelation');
title('Autocorrelation of Female Voice');
grid on;

