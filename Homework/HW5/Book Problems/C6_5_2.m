cgate = @(t) (abs(t) < 0.5) + 0.5.*(abs(t) == 0.5);
ddelta = @(n) (n<0.000001 & n>-0.000001);           % discrete Kronecker delta
B = 10000*pi;                   % Width of signal in time domain
T = 0.001;                      % sampling interval of 1 ms
DACmax = 3.3;
DACmin = 0;

xc = @(t) sinc(t.*B/pi);        % Continuous time input
Xc = @(w) (pi/B).*cgate(w ./ (2*B));

x = @(n) xc(n.*T) .* (mod(n,1)==0);% Discrete time sampled signal
X = @(w) 1;

y = @(n) ((cos(pi.*n)./(n.*T)).*(n~=0) + 0.*(n==0)).*(mod(n,1)==0);
Y = @(w) w.*j/T .* (abs(w) <= pi);

%yc = @(t) DACmax.*(sinc(t.*B/pi) >= 0) + DACmin.*(sinc(t.*B/pi) <= 0);

% Sketch xc(t)
subplot(4,2,1); t = -T:T/1000:T; 
plot(t,xc(t),'k'); xlabel('time (s)'); ylabel('x_c(t)'); 
title('Signal Inputted into ADC'); grid on;
% Sketch Xc(w)
subplot(4,2,2); w = -B-B/10:B/1000:B+B/10; 
plot(w,Xc(w),'k'); xlabel('frequency (\omega)'); ylabel('X_c(\omega)'); 
title('Spectra of signal Inputted into ADC'); grid on;


% Sketch x[n]
subplot(4,2,3); n = -5:5; 
stem(n,x(n),'k'); xlabel('n'); ylabel('x[n]'); 
title('Signal Inputted into H(\Omega)'); grid on;
% Sketch X(W)
subplot(4,2,4);
yline(1,'k'); xlabel('frequency (\Omega)'); ylabel('X(\Omega)'); 
title('Spectra of signal Inputted into H(\Omega)'); grid on; axis([-pi pi 0 1.1]);


% Sketch y[n]
subplot(4,2,5); n = -20:20;
stem(n,y(n),'k'); xlabel('n'); ylabel('y[n]'); 
title('Signal Outputted from H(\Omega)'); axis tight; grid on;
% Sketch Y(W)
subplot(4,2,6); W = -pi:0.001:pi; 
plot(W,abs(Y(W)),'k'); xlabel('frequency (\Omega)'); ylabel('X(\Omega)'); 
title('Spectra of signal Outputted from H(\Omega)'); grid on;



% Sketch y(t)
N = 1000;
subplot(4,2,7); t = -0.01:0.0001:0.01;
yc = 0;
for n = -N:N
    if n~=0
        yc = yc + y(n) .* sinc((t - n*T)./T);       
    end
end
plot(t,yc,'k'); xlabel('time (s)'); ylabel('y_c(t)'); 
title('Signal Outputted from DAC'); grid on;
% Sketch Yc(w)
subplot(4,2,8); w = -B-B/10:B/1000:B+B/10; 
% plot(w,Yc(w),'k'); xlabel('frequency (\omega)'); ylabel('Y_c(\omega)'); 
title('Spectra of signal Outputted from DAC'); grid on;




