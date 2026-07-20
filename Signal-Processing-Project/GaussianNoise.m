% Load ECG signal data with Gaussian noise
load('Necg.csv'); % replace with your own ECG signal data

% Define filter parameters
fs = 1000; % sampling frequency (Hz)
fcut = 50; % cutoff frequency for lowpass filter (Hz)
order = 2; % order of the filter

% Design lowpass filter using Butterworth filter design
[b, a] = butter(order, fcut/(fs/2), 'low');

% Apply lowpass filter to ECG signal using filtfilt
ecg_filtered = filtfilt(b, a, Necg);

% Plot original ECG signal with Gaussian noise in red color
t = (0:length(Necg)-1)/fs; % time vector
figure;
plot(t, Necg, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original ECG Signal with Gaussian Noise');

% Plot filtered ECG signal without Gaussian noise in blue color
figure;
plot(t, ecg_filtered, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered ECG Signal without Gaussian Noise');