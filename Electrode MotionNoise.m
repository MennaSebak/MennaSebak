% Load ECG signal data with electrode motion noise
load('Necg.csv'); % replace with your own ECG signal data

% Define filter parameters
fs = 1000; % sampling frequency (Hz)
f1 = 49; % lower stopband frequency (Hz)
f2 = 51; % upper stopband frequency (Hz)
order = 3; % order of the filter

% Design bandstop filter using Butterworth filter design
[b, a] = butter(order, [f1 f2]/(fs/2), 'stop');

% Apply bandstop filter to ECG signal using filtfilt
ecg_filtered = filtfilt(b, a, Necg);

% Plot original ECG signal with electrode motion noise in red color
t = (0:length(Necg)-1)/fs; % time vector
figure;
plot(t, Necg, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original ECG Signal with Electrode MotionNoise');

% Plot filtered ECG signal without electrode motion noise in blue color
figure;
plot(t, ecg_filtered, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered ECG Signal without Electrode Motion Noise');