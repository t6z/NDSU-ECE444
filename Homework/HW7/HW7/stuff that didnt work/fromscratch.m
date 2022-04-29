
clear variables; close all;
freq = [31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000]';
Hd_dB = [-1.1, -2.2, -4.8, -0.9, 0.6, 2.3, -1.3, 4.5, -3.2, -6.8]';
Hd = db2mag(Hd_dB);

Hd = 
figure(); stem(freq,Hd,'k'); xlabel('Frequency (Hz)'); ylabel('Select Points of H_d(\Omega) (dB)');
set(gca,'xscal','log')
Fs = 20000; Ts = 1/Fs;

Lh = length(Hd);

K = 10 * Lh;

for l = 1:K
   a(l) = (1/K) * sum(exp(j.*(0:K-1).*l*2*pi/K));    
end

A = toeplitz(a);

for l = 1:K
   b(l) = (1/K) * sum(exp(j.*(0:K-1).*l*2*pi/K));    
end

% for l = 1:K
%    b(l) = 
% end



