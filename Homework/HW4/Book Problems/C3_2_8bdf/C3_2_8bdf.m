close all % closes all open figures

Fs = 20; % sampling frequency
Ts = 1/Fs; % sampling period
f = [12,21,32]; % different f0 from problem
for k = 1:3
    LCM = lcm(Fs,f(k)); % Least Common Multiple of Fs and F0
    Mult = LCM / Fs; % Number of times Sinusoid of F0 will repeat until next apparent period
    MultS = LCM / f(k); % Number of times Sinusoid of F0 is sampled until next apparent period
    T = 1/f(k); % Period of sinusoid with frequency F0
    x = @(t) sin(2*pi*f(k).*t); % create anonymous function of frequency F0
    t = 0:0.001:Mult*T; 
    subplot(3,1,k); plot(t,x(t),'k','LineWidth',1); hold on;
    
    % plot points sampled at 20Hz
    for l = 0:MultS
       stem(l.*Ts, x(l.*Ts),'r','LineWidth',1); hold on;
    end
    
    axis([-0.001 max(t)+0.001 -1.01 1.01]); title("Sinusoid of " + num2str(f(k)) + "Hz vs Fs = 20Hz");
end

f2 = figure();
r = 5; % times to repeat new apparent frequency signal
for k = 1:3
    LCM = lcm(Fs,f(k)); % Least Common Multiple of Fs and F0
    MultS = LCM / f(k); % Number of times Sinusoid of F0 is sampled until next apparent period
    Mult = LCM / Fs; % Number of times Sinusoid of F0 will repeat until next apparent period
    T = 1/f(k); % Period of sinusoid with frequency F0

    x = @(t) sin(2*pi*f(k).*t); % create anonymous function of frequency F0
    t = 0:0.001:r*Mult*T; 

    for l = 0:r*MultS
       subplot(3,1,k);
       stem(l.*Ts, x(l.*Ts),'k','LineWidth',1); hold on;
       title("Repeated Apparent frequency signal five times for f0 = "+f(k)+"Hz");
    end
end






