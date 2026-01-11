close all; clear all; clc;

% Phone number to encode
phoneNumber = '5196612128';

% Sampling frequency
fs = 8000;

% Generate the DTMF signal
encodedSignal = generateDTMF(phoneNumber);

% Decode the DTMF signal
decodedNumber = decodeDTMF(encodedSignal, fs);

% Display the results
fprintf('Original Phone Number: %s\n', phoneNumber);
fprintf('Decoded Phone Number: %s\n', decodedNumber);

% Plot the encoded signal for visualization
t = (0:length(encodedSignal)-1) / fs;
figure;
plot(t, encodedSignal);
title('DTMF Encoded Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
sound(encodedSignal, fs);
%%
function signal = generateDTMF(phoneNumber)
    % generateDTMF generates a DTMF signal corresponding to a digit sequence
    % Input: phoneNumber - string representing the phone number (e.g., '1234567890')
    % Output: signal - generated DTMF signal
    
    % Frequency allocation for each row and column
    fL = [697, 770, 852, 941]; % Low frequencies (Hz)
    fH = [1209, 1336, 1477]; % High frequencies (Hz)
    
    % Sampling parameters
    fs = 8000; % Sampling frequency (Hz)
    duration = 0.065; % Duration of each DTMF tone (seconds)
    space_duration = 0.065; % Duration of silence (seconds)
    t = 0:1/fs:duration-1/fs; % Time vector for each tone
    
    % Tone mapping based on the provided table
    toneMap = [
        '1', '2', '3'; 
        '4', '5', '6'; 
        '7', '8', '9'; 
        '*', '0', '#'
    ];
    
    % Generate the DTMF signal for each digit in the phone number
    signal = [];
    for i = 1:length(phoneNumber)
        % Find the corresponding frequencies for the digit
        [row, col] = find(toneMap == phoneNumber(i));
        if isempty(row) || isempty(col)
            error('Invalid character in phone number');
        end
        fL_selected = fL(row);
        fH_selected = fH(col);
        
        % Generate the dual-tone signal
        tone = cos(2*pi*fL_selected*t) + cos(2*pi*fH_selected*t);
        
        % Append tone and space to the final signal
        signal = [signal, tone, zeros(1, round(space_duration * fs))];
    end
    
    % Normalize the signal to avoid clipping
    signal = signal / max(abs(signal));
end
%%
function phoneNumber = decodeDTMF(signal, fs)
    % decodeDTMF decodes a DTMF signal to a phone number string using FFT
    % Input: signal - the DTMF signal
    %        fs - sampling frequency (Hz)
    % Output: phoneNumber - decoded phone number string
    
    % Frequency allocation for each row and column
    fL = [697, 770, 852, 941]; % Low frequencies (Hz)
    fH = [1209, 1336, 1477]; % High frequencies (Hz)
    
    % Tone mapping based on the provided table
    toneMap = [
        '1', '2', '3'; 
        '4', '5', '6'; 
        '7', '8', '9'; 
        '*', '0', '#'
    ];
    
    % Parameters for the FFT
    N = 2048; % FFT length
    threshold = 0.2; % Threshold for frequency detection
    
    % Define the duration of tone and space (65 ms)
    segment_length = round(0.065 * fs);
    
    % Initialize phone number
    phoneNumber = '';
    
    % Split the signal into segments
    num_segments = floor(length(signal) / segment_length);
    for i = 1:num_segments
        segment = signal((i-1) * segment_length + 1 : i * segment_length);
        
        % Apply FFT to the segment
        Y = abs(fft(segment, N));
        Y = Y(1:N/2+1); % Consider only positive frequencies
        freq = (0:N/2) * (fs / N); % Frequency vector
        
        % Find the peak frequencies
        [~, idx] = sort(Y, 'descend');
        peak_freqs = freq(idx(1:2));
        
        % Identify low and high frequency components
        fL_detected = min(peak_freqs);
        fH_detected = max(peak_freqs);
        
        % Find the closest match for low and high frequencies
        [~, row] = min(abs(fL - fL_detected));
        [~, col] = min(abs(fH - fH_detected));
        
        % Decode the corresponding digit
        digit = toneMap(row, col);
        
        % Append digit to phone number
        phoneNumber = [phoneNumber, digit];
    end
end