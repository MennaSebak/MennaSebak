% Load ECG signal data
load('Necg.csv'); % replace with your own ECG signal data

% Define filter parameters
fs = 1000; % sampling frequency (Hz)
fcut = 15; % cutoff frequency for lowpass filter (Hz)
order = 2; % order of the filter

% Design lowpass filter using Butterworth filter design
[b, a] = butter(order, fcut/(fs/2), 'low');

% Apply lowpass filter to ECG signal using filtfilt
ecg_filtered = filtfilt(b, a, Necg);

% Differentiate filtered ECG signal using central difference method
ecg_diff = diff(ecg_filtered);

% Square differentiated ECG signal
ecg_squared = ecg_diff.^2;

% Integrate squared ECG signal using moving window integration
N = 30; % window size
ecg_integrated = movmean(ecg_squared, N);

% Find R-peaks using Pan-Tompkins algorithm
[~,locs] = findpeaks(ecg_integrated, 'MinPeakHeight', max(ecg_integrated)/2, 'MinPeakDistance', fs/2);

% Plot original ECG signal in red color
t = (0:length(ecg_signal)-1)/fs; % time vector
figure;
plot(t, Necg, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Original ECG Signal');

% Plot detected R-peaks in blue color
hold on;
plot(t(locs), Necg(locs), 'bo', 'MarkerSize', 5);
hold off;
legend('Original ECG', 'Detected R-Peaks');