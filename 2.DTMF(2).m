function decoded_digits = decode_dtmf(dtmf_signal, fs)
    % DTMF Frequencies
    fL = [697, 770, 852, 941];  % Low frequencies
    fH = [1209, 1336, 1477];    % High frequencies
    keypad = ['1', '2', '3'; 
              '4', '5', '6'; 
              '7', '8', '9'; 
              '*', '0', '#'];

    % Parameters for detection
    threshold = 0.1;            % Magnitude threshold for peak detection
    segment_duration = 0.13;    % Duration of each segment (tone + silence)

    decoded_digits = '';  % Initialize output

    % Segment the DTMF signal
    segment_length = round(segment_duration * fs);
    num_segments = floor(length(dtmf_signal) / segment_length);

    for i = 1:num_segments
        segment = dtmf_signal((i-1)*segment_length + 1:i*segment_length);
        % Apply FFT
        Y = fft(segment);
        magnitude_spectrum = abs(Y(1:segment_length/2));  % Positive frequencies
        f = (0:segment_length/2-1)*(fs/segment_length);  % Frequency vector

        % Identify dominant frequencies
        [peaks, locs] = findpeaks(magnitude_spectrum, 'MinPeakHeight', threshold);
        dominant_freqs = f(locs);

        % Map the frequencies to DTMF digits
        detected_digit = identify_digit(dominant_freqs, fL, fH, keypad);
        if ~isempty(detected_digit)
            decoded_digits = [decoded_digits, detected_digit];
        end
    end
end

function detected_digit = identify_digit(dominant_freqs, fL, fH, keypad)
    detected_digit = '';
    if length(dominant_freqs) >= 2
        % Find closest frequencies in fL and fH
        [~, idx1] = min(abs(dominant_freqs(1) - fL)); % Low frequency
        [~, idx2] = min(abs(dominant_freqs(2) - fH)); % High frequency

        % Check if they correspond to a valid key
        if ~isempty(idx1) && ~isempty(idx2)
            detected_digit = keypad(idx1, idx2);
        end
    end
end
