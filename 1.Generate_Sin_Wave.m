% MATLAB script to generate 1 second of 10 Hz sine wave with harmonics  
  
% Parameters  
fs = 800;           % Sample rate (Hz)  
t = 0:1/fs:1-1/fs;  % Time vector (1 second),0 is the fundamental value and 1/fs is the interval，1-1/fs is the endpoint o 
f_fund = 10;        % Fundamental frequency (Hz)
A_fund = 1;         % Amplitude of fundamental (peak)  
  
% Generate fundamental signal  
y = A_fund * sin(2 * pi * f_fund * t); % y=asin(2*pi*t)
  
% Loop to add harmonics  
for n = 2:20  
    % Calculate amplitude of nth harmonic  
    A_harm = A_fund / n;  
      
    % Generate nth harmonic signal  
    y_harm = A_harm * sin(2 * pi * n * f_fund * t); %y=sin(2*pi*n*t)
      
    % Add harmonic to the signal  
    y = y + y_harm;  
      
    % Display the waveform after each harmonic is added  
   % figure;  
   % subplot(20,1,n-1);  % Subplot position based on the loop index  
   % plot(t, y);  
   % title(['Waveform after adding ', num2str(n), 'st harmonic']);  
   % xlabel('Time (s)');  
   % ylabel('Amplitude');  
   % grid on;  
end  
  
% Display the final waveform with all harmonics  
figure; %创建一个新的图像窗口
plot(t, y); %创建图像的x轴、y轴
title('Final Waveform with All Harmonics (up to 20th)'); %创建图标的标题 
xlabel('Time (s)');%用于给x轴添加标签  
ylabel('Amplitude');  
grid on%grid on 是一个命令，用于在当前图形上添加网格线