% Models
delta = @(w) 1.*(w<=0.001 & w>=-0.001);
unitT = @(w) (1 - 2.*abs(w)) .* (abs(w) <= 0.5);


% x = @(t) cos(20.*pi.*t) + 5.*(sinc(5.*t)).^2;
% T = [1/10;1/20;1/21];
% 
% for m = 1:3
%     subplot(4,1,m);
%     t = 0:T(m,1):0.8;
%     plot(t,x(t),'k');
% end


X = @(w) pi.*(delta(w-20*pi) + delta(w+20*pi)) + 5.*unitT(w ./ (20*pi));
f = -15:0.01:15;
subplot(4,1,1);
plot(f,X(2*pi.*f),'k'); xlabel("frequency (Hz)"); title("Frequency Spectrum of x(t)");

colors = char(['r','g','b']);

subplot(4,1,2);
Fs = 10; % sampling frequency of 10Hz
for k = -1:1
    plot(f+k.*Fs,X(2*pi.*f),colors(1,k+2)); xlabel("frequency (Hz)"); title("Frequency Spectrum of x_1_0_H_z(t)");
    hold on;
end

subplot(4,1,3);
Fs = 20; % sampling frequency of 10Hz
for k = -1:1
    
    plot(f+k.*Fs,X(2*pi.*f),colors(1,k+2)); xlabel("frequency (Hz)"); title("Frequency Spectrum of x_2_0_H_z(t)");
    hold on;
end

subplot(4,1,4);
Fs = 21; % sampling frequency of 10Hz
for k = -1:1
    
    plot(f+k.*Fs,X(2*pi.*f),colors(1,k+2)); xlabel("frequency (Hz)"); title("Frequency Spectrum of x_2_1_H_z(t)");
    hold on;
end




