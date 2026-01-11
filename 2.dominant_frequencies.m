% Step 1: Load the vibration data
data = load('vbrdata.dat');
fs = 1000;  % Sampling frequency in Hz
N = length(data);  % Length of the data
t = (0:N-1) / fs;  % Time vector

% Step 2: Plot the waveform
figure;
subplot(2, 1, 1);
plot(t, data);
title('Vibration Signal Waveform');
xlabel('Time (s)');
ylabel('Acceleration Response');
grid on;

% Step 3: Compute the magnitude spectrum
f = (0:N-1)*(fs/N);  % Frequency vector
Y = fft(data);  % Compute the FFT
magnitude_spectrum = abs(Y);  % Get the magnitude

% Step 4: Plot the magnitude spectrum
subplot(2, 1, 2);
plot(f(1:N/2), magnitude_spectrum(1:N/2));  % Plot only positive frequencies
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 fs/2]);  % Limit x-axis to Nyquist frequency
grid on;

% Step 5: Analyze the spectrum to find dominant frequencies
[peak_magnitudes, peak_indices] = findpeaks(magnitude_spectrum(1:N/2), 'SortStr', 'descend', 'NPeaks', 4);
dominant_frequencies = f(peak_indices);  % Corresponding frequencies

% Display results
fprintf('Four dominant frequencies (modes):\n');
for i = 1:length(dominant_frequencies)
    fprintf('Mode %d: %.2f Hz (Magnitude: %.2f)\n', i, dominant_frequencies(i), peak_magnitudes(i));
end
