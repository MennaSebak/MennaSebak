% Generate a clean signal
Fs = 1000; % Sampling frequency
t = 0:1/Fs:1-1/Fs; % Time vector
f = 10; % Signal frequency
x = sin(2*pi*f*t); % Clean signal

% Add different types of noise
noise_amplitude = 0.1;
x_noisy1 = x + noise_amplitude * randn(size(t)); % Gaussian noise
x_noisy2 = x + noise_amplitude * rand(size(t)); % Uniform noise
x_noisy3 = x + noise_amplitude * sin(2*pi*50*t); % Sinusoidal noise
x_noisy4 = x + noise_amplitude * sign(randn(size(t))); % Impulse noise
x_noisy5 = x + noise_amplitude * randn(size(t)) + 0.5*sin(2*pi*150*t); % Gaussian noise + sinusoidal noise
dropout_prob = 0.2; % Probability of dropout
dropout_mask = rand(size(x)) < dropout_prob; % Generate dropout mask
x_noisy6 = x .* (~dropout_mask); % Apply dropout mask to x
% Remove noise using a median filter
window_size = 51;
x_filtered1 = medfilt1(x_noisy1, window_size);
x_filtered2 = medfilt1(x_noisy2, window_size);
x_filtered3 = medfilt1(x_noisy3, window_size);
x_filtered4 = medfilt1(x_noisy4, window_size);
x_filtered5 = medfilt1(x_noisy5, window_size);
x_filtered6 = medfilt1(x_noisy6, window_size);

% Plot the signals
figure;
subplot(6, 2, 1);
plot(t, x);
title('Clean Signal');
ylabel('Amplitude');
subplot(6, 2, 2);
plot(t, x_noisy1);
title('Gaussian Noise');
ylabel('Amplitude');
subplot(6, 2, 3);
plot(t, x_filtered1);
title('Gaussian Noise Filtered');
ylabel('Amplitude');
subplot(6, 2, 4);
plot(t, x_noisy2);
title('Uniform Noise');
ylabel('Amplitude');
subplot(6, 2, 5);
plot(t, x_filtered2);
title('Uniform Noise Filtered');
ylabel('Amplitude');
subplot(6, 2, 6);
plot(t, x_noisy3);
title('Sinusoidal Noise');
ylabel('Amplitude');
subplot(6, 2, 7);
plot(t, x_filtered3);
title('Sinusoidal Noise Filtered');
ylabel('Amplitude');
subplot(6, 2, 8);
plot(t, x_noisy4);
title('Impulse Noise');
ylabel('Amplitude');
subplot(6, 2, 9);
plot(t, x_filtered4);
title('Impulse Noise Filtered');
ylabel('Amplitude');
subplot(6, 2, 10);
plot(t, x_noisy5);
title('Gaussian + Sinusoidal Noise');
ylabel('Amplitude');
subplot(6, 2, 11);
plot(t, x_filtered5);
title('Gaussian + Sinusoidal Noise Filtered');
ylabel('Amplitude');
xlabel('Time (s)');
subplot(6, 2, 12);
plot(t, x_noisy6);
title('Random Dropout Noise');
ylabel('Amplitude');
xlabel('Time (s)');
ylim([-1.5 1.5]);

sgtitle('Signal with Different Types of Noise');

% Adjust subplot spacing
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'WindowStyle', 'docked');
set(gcf, 'Resize', 'off');
set(gcf, 'Units', 'Inches', 'Position', [0 0 10 15]);
set(gcf, 'PaperUnits', 'Inches', 'PaperPosition', [0 0 10 15]);