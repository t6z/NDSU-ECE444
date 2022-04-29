

x_c = @(t) sin(0.7*pi.*t).*cos(0.5*pi.*t);

Fs = 1; % Sampling frequency of 1Hz
Ts = 1/Fs; % Sampling Period

t = -10:0.01:10;
n = -10:10;
subplot(4,1,1); plot(t,x_c(t),'k'); title("signal x(t)"); xlabel("t");

subplot(4,1,2); stem(n,x_c(n),'k'); title("sampled signal x[n]"); xlabel("n");



