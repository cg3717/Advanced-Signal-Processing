clear all;

c = struct('red', [220/255  20/255  60/255], ... 
    'darkred', [139/255   0   0], ...
    'orange', [255/255 165/255   0],...
    'yellow', [255/255 230/255 0] );

%% 
rng(0,'twister');
r(1:3) = [0 2 0];
r(4:11) = randi([0 9],1,8);
N = 0.25*32768;

f = zeros(11,2);
for m = 1:11
    [f(m,1), f(m,2)] = freqs(r(m));
end
%% 3.4.1
t = 0 : (1/32768) : 5.50-(1/32768);
for m = 1:11
    f1 = f(m,1);
    f2 = f(m,2);
    s1 = (N*2*(m-1)+1); e1 = (N*(2*m-1));
    out(s1:e1) = sin(2*pi*f1*t(s1:e1)) + sin(2*pi*f2*t(s1:e1));
    out(N*(2*m-1)+1 : N*2*m) = 0;
end
figure;
plot(t, out, '-', 'color', c.darkred);
title('Dial tone pad - time domain signal ', 'FontSize', 15); grid on;
xlabel('Time (s)', 'FontSize', 15); ylabel('Amplitude', 'FontSize', 15); axis([0 5.25 -inf inf])

%% 3.4.2
spectrogram(out, hann(8192), 0, 8192, 32768, 'yaxis');
ylim([0 2])
colormap hot;
title('Spectrogram of London landline number', 'FontSize', 15);

%% 3.4.4
std_n = [0.05 1 5 10];
figure;
for i=1:4
    n = randn(1, 5.50*32768)*std_n(i);
    outNoise = out + n;
    subplot(1,4,i); 
%     plot(t, outNoise, '-', 'color', c.darkred);
%     axis([0 0.005 -inf inf])
    spectrogram(outNoise, hann(8192), 0, 8192, 32768, 'yaxis'); colormap hot;
    ylim([0 2])
    title(['\sigma_N = ' num2str(std_n(i))])
end
