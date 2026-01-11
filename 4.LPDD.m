% Specifications
fc = 100;        % Cutoff frequency (Hz)
fs = 1000;       % Sampling frequency (Hz)
tw = 50;         % Transition width (Hz)
A = 55;          % Stopband attenuation (dB)

% Kaiser window parameters
beta = 0.1102 * (A - 8.7);   % Shape parameter
N = ceil((A - 8) / (2.285 * (2 * pi * (tw / fs))));  % Filter order
if mod(N, 2) == 0
    N = N + 1;  % Ensure odd order for symmetry
end
M = (N - 1) / 2;  % Half of filter length

% Impulse response for LPDD
n = -M:M;  % Symmetric range
h = zeros(size(n));  % Initialize impulse response
for i = 1:length(n)
    if n(i) ~= 0
        h(i) = -2 * pi * fc / fs * cos(2 * pi * fc * n(i) / fs) / (n(i)^2);
    end
end

% Set the middle coefficient to zero (n=0)
h(n == 0) = 0;

% Apply Kaiser window
w = kaiser(N, beta)';  % Kaiser window
h_lpdd = h .* w;       % .*表示点对点相乘，最后加权结果


data = load('quakedata.mat');
displacemnt = data.drift_data;
% Load the data
data = load('quakedata.mat');
displacement = data.drift_data;

% Define the sampling frequency
fs = 1000;  % Adjust if needed based on your data's sampling rate

% Calculate velocity (first derivative of displacement)
velocity = diff(displacement) * fs;  % Multiply by fs to convert to velocity in units/time

% Calculate acceleration (second derivative of displacement)
acceleration = diff(velocity) * fs;  % Multiply by fs to convert to acceleration in units/time^2

% Time vector for plotting (excluding the last sample due to diff operation)
t_displacement = (0:length(displacement)-1) / fs;
t_velocity = (0:length(velocity)-1) / fs;
t_acceleration = (0:length(acceleration)-1) / fs;

% Plot displacement, velocity, and acceleration
figure;
subplot(3, 1, 1);
plot(t_displacement, displacement);
title('Displacement');
xlabel('Time (s)');
ylabel('Displacement');

subplot(3, 1, 2);
plot(t_velocity, velocity);
title('Velocity');
xlabel('Time (s)');
ylabel('Velocity');

subplot(3, 1, 3);
plot(t_acceleration, acceleration);
title('Acceleration');
xlabel('Time (s)');
ylabel('Acceleration');
