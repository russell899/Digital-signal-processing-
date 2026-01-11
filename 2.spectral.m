% Load the male and female voice samples
[male_signal, Fs_male] = audioread('m1.wav'); % Load male voice
[female_signal, Fs_female] = audioread('f1.wav'); % Load female voice

% Define a function to compute and plot the waveform and magnitude spectrum
function plot_waveform_and_spectrum(signal, Fs, title_str)
    L = length(signal); % Length of the signal
    t = (0:L-1) / Fs;   % Time vector

    % Compute FFT
    Y = fft(signal);
    P2 = abs(Y / L);                  % Double-sided amplitude spectrum
    P1 = P2(1:L/2+1);                 % Single-sided amplitude spectrum
    P1(2:end-1) = 2 * P1(2:end-1);   % Adjust for single-sided spectrum
    f = Fs * (0:(L/2)) / L;           % Frequency vector

    % Create a figure with subplots
    figure;

    % Plot the waveform
    subplot(2, 1, 1);
    plot(t, signal);
    title(['Waveform of ', title_str]);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    grid on;

    % Plot the magnitude spectrum
    subplot(2, 1, 2);
    plot(f, P1);
    title(['Magnitude Spectrum of ', title_str]);
    xlabel('Frequency (Hz)');
    ylabel('|P1(f)|');
    grid on;

    % Find the fundamental frequency
    [~, idx] = max(P1);   % Find the index of the maximum value in P1
    fundamental_freq = f(idx); % Corresponding frequency

    % Display the fundamental frequency
    fprintf('Fundamental Frequency for %s: %.2f Hz\n', title_str, fundamental_freq);
end

% Plot for male signal
plot_waveform_and_spectrum(male_signal, Fs_male, 'Male Voice');

% Plot for female signal
plot_waveform_and_spectrum(female_signal, Fs_female, 'Female Voice');
