% Load ECG signal data
load('Necg.csv'); % replace with your own ECG signal data

% Add Gaussian noise with 10 dB SNR
noise_power = 0.1 * norm(Necg)^2 / length(Necg); % calculate noise power
noise = sqrt(noise_power) * randn(size(Necg)); % generate Gaussian noise
Necg = Necg + noise; % add noise to ECG signal

% Set parameters for STFT
fs = 1000; % sampling frequency (Hz)
winlen = 0.5; % window length (seconds)
noverlap = round(winlen/2); % overlap between windows
nfft = 1024; % FFT size

% Compute STFT of noisy ECG signal
[S, F, T] = spectrogram(Necg, winlen*fs, noverlap*fs, nfft, fs);

% Plot time-frequency spectrum
imagesc(T, F, 20*log10(abs(S))); % convert to dB for better visualization
axis xy; % flip Y-axis to match conventional ECG plots
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Noisy ECG Time-Frequency Spectrum (SNR= 10 dB)');
colorbar;