% Load ECG signal data with baseline wander noise
load('Necg.csv'); % replace with your own ECG signal data

% Define filter parameters
fs = 1000; % sampling frequency (Hz)
fcut = 0.5; % cutoff frequency for highpass filter (Hz)
order = 2; % order of the filter

% Design highpass filter using Butterworth filter design
[b, a] = butter(order, fcut/(fs/2), 'high');

% Apply highpass filter to ECG signal using filtfilt
ecg_filtered = filtfilt(b, a, Necg);

% Plot original ECG signal with baseline wander noise in red color
t = (0:length(Necg)-1)/fs; % time vector
figure;
plot(t, Necg, 'y');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original ECG Signal with Baseline Wander Noise');

%Plot filtered ECG signal without baseline wander noise in blue color
figure;
plot(t, ecg_filtered, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered ECG Signal without Baseline Wander Noise');