function dtmf_signal = generate_dtmf(phone_number)
    % DTMF Frequencies
    fL = [697, 770, 852, 941];  % Low frequencies
    fH = [1209, 1336, 1477];    % High frequencies
    fs = 8000;                  % Sampling frequency
    mark_duration = 0.065;      % Duration of tone burst (in seconds)
    space_duration = 0.065;     % Duration of silence (in seconds)

    % Create an empty signal
    dtmf_signal = [];

    % Keypad mapping for digits
    keypad = ['1', '2', '3'; 
              '4', '5', '6'; 
              '7', '8', '9'; 
              '*', '0', '#'];

    % Loop through each digit in the phone number
    for i = 1:length(phone_number)
        digit = phone_number(i);
        if ismember(digit, keypad)
            [row, col] = find(keypad == digit);
            % Determine corresponding frequencies
            f1 = fL(row);  % Low frequency
            f2 = fH(col);  % High frequency

            % Generate the DTMF tone
            n = 0:1/fs:mark_duration;  % Time vector
            tone = cos(2 * pi * f1 * n) + cos(2 * pi * f2 * n);  % DTMF tone
            
            % Append tone and silence to the signal
            dtmf_signal = [dtmf_signal, tone, zeros(1, round(space_duration * fs))];
        end
    end
end
