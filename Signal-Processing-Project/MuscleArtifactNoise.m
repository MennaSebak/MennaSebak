% Load ECG signal data with muscle artifact noise
load('Necg.csv'); % replace with your own ECG signal data

% Define filter parameters
fs = 1000; % sampling frequency (Hz)
fcut = 0.5; % cutoff frequency for highpass filter (Hz)
order = 2; % order of the filter

% Design highpass filter using Butterworth filter design
[b, a] = butter(order, fcut/(fs/2), 'high');

% Apply highpass filter to ECG signal using filtfilt
ecg_filtered = filtfilt(b, a, Necg);

% Plot original ECG signal
t = (0:length(Necg)-1)/fs; % time vector
figure;
plot(t, Necg, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original ECG Signal with Muscle Artifact Noise');

% Plot filtered ECG signal
figure;
plot(t, ecg_filtered, 'g');
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered ECG Signal with Muscle Artifact Noise');