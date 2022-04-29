clear variables; close all;
Fs = 20e3; T = 1 / Fs;
Omegap = 20*2*pi*T; 
Omegas = 10e3*2*pi*T; 

% desired freqs
freq_bands = 2.^[1:10] .* 10;
bands = freq_bands.*2*pi*T;

gain_db = [4 3.5 2 1 -1 -1 1 2 3.5 4];
gain = db2mag(gain_db);
% Bl = [20 40];
% Bm = [40 80];
% Bu = [80 160];

deltap = 1; 
deltas = .01;
Lh = 20; 
K = 100*Lh; 
k = (0:K-1); 
Omegak = k*2*pi/K;
Q = (Omegak<=Omegap)/((deltap/2)^2)+(Omegak>=Omegas)/(deltas^2);
Q(fix(K/2)+2:end) = Q(round(K/2):-1:2);


Hd = gain(1)*(bands(1)<=Omegak & Omegak<bands(2)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(2)*(bands(2)<=Omegak & Omegak<bands(3)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(3)*(bands(3)<=Omegak & Omegak<bands(4)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(4)*(bands(4)<=Omegak & Omegak<bands(5)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(5)*(bands(5)<=Omegak & Omegak<bands(6)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(6)*(bands(6)<=Omegak & Omegak<bands(7)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(7)*(bands(7)<=Omegak & Omegak<bands(8)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(8)*(bands(8)<=Omegak & Omegak<bands(9)).*exp(-1j*k*pi*(Lh-1)/K) ...
    + gain(9)*(bands(9)<=Omegak & Omegak<bands(10)).*exp(-1j*k*pi*(Lh-1)/K);

Hd(fix(K/2)+2:end) = conj(Hd(round(K/2):-1:2));
l = (0:Lh-1)'; a = exp(1j*l*Omegak)*Q.'/K; b = exp(1j*l*Omegak)*(Hd.*Q/K).';
A = toeplitz(a); 
h = (A\b);
n = (0:Lh-1)'; subplot(211); stem(n,h);
Omega = linspace(0,pi,1001); H = polyval(h,exp(1j*Omega)).*exp(-1j*(Lh-1)*Omega);
subplot(212); semilogx(Omega,abs(H));
hold on; semilogx(linspace(0,max(Omega),length(Hd)),abs(Hd),'k');

