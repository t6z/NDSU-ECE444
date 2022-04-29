% ECE 444 HW6
% Fall 2020
% Thomas Smallarz
format short; close all; clear variables;
%% Design Low-Pass Inverse Chebyshev Prototype Filter with normalized freq
% Based on Ex. 2.17
K = 20;
alphap = 2; % pass-band alpha of 2dB
alphas = 20; % stop-band alpha of 20dB
omegap = 1; % prototype filter cutoff freq of 1 rad/sec
% calculate stop-band frequency based on alpha's and omega
omegas = omegap*cosh(acosh(sqrt((10^(alphas/10)-1)/(10^(alphap/10)-1)))/K);

epsilon = 1/sqrt(10^(alphas/10)-1); 
k = 1:K;

% calculate poles
pk = -omegap*sinh(asinh(1/epsilon)/K)*sin(pi*(2*k-1)/(2*K))+...
    1j*omegap*cosh(asinh(1/epsilon)/K)*cos(pi*(2*k-1)/(2*K));
pk = omegap*omegas./pk; 

% calculate zeros
zk = 1j*omegas.*sec(pi*(2*k-1)/(2*K));

% calculate coefficients of expanded form based on poles/zeros
B = prod(pk./zk)*poly(zk); A = poly(pk);
%fprintf("B:\n"); disp(B');
%fprintf("A:\n"); disp(A');

% plot pole/zero plot for CT LP Inv. Chebyshev Proto filter
% fig1 = figure(); plot(real(pk),imag(pk),'kx'); grid on;
% hold on; plot(real(zk),imag(zk),'ko');
% title("P/Z Plot of Continuous-Time Lowpass Inverse Chebyshev Prototype Filter");

%% Digital Bandpass IIR Filter Conversion
% Based on Ex. 8.7
Fs = 10000; % 10kHz sampling frequency
T = 1/Fs; % Sampling period.

fp1 = 250; % lower pass band frequencies (Hz)
fp2 = Fs / 2 - fp1; % upper pass band frequencies (Hz)

wp1 = 2*pi.*fp1; wp2 = 2*pi.*fp2; % convert from Hz to Rad/Sec
wp1_w = tan(wp1.*T/2); % SIMPLIFIED procedure for pre-warped lower passband omegas
wp2_w = tan(wp2.*T/2); % SIMPLIFIED procedure for pre-warped upper passband omegas

c1 = (wp1_w*wp2_w - 1) / (wp1_w*wp2_w + 1);
c2 = (wp2_w - wp1_w) / (wp1_w*wp2_w + 1);

% If the lengths of c1&c2 and zk&pk are not the same, the rest of code has
% issues
if length(c2) ~= length(c1)
    fprintf("Something's wrong... c1 and c2 have different lengths 0.o")
end
if length(zk) ~= length(pk)
    fprintf("Something may be wrong... zk and pk have different lengths 0.o")
end

% *******************************
% ******* COMPUTING P/Z's *******
% *******************************

% computing coefficients for zeros of H(z) as defined in eq. 8.25
for i = 1:length(zk)
   Zdig(i,:) = roots([1, 2*c1./(1-c2*zk(i)), (1+c2*zk(i))./(1-c2*zk(i))]);
end

% appending columns of zeros, then sorting by imag value
temp = -j.*Zdig;
temp2 = sort([temp(:,1);temp(:,2)],'ComparisonMethod','real');
Zdig_sort = j.*temp2;
clear temp temp2;

% create 2nd order real systems to cascade
I = length(Zdig);
for i = 1:I
    Zdig_2Order(i,:) = poly([Zdig_sort(2*i-1,1),Zdig_sort(2*i,1)]);
end

% computing poles of H(z) as defined in eq. 8.25
for i = 1:length(pk)
   Pdig(i,:) = roots([1, 2*c1./(1-c2*pk(i)), (1+c2*pk(i))./(1-c2*pk(i))]);
end

% appending columns of poles, then sorting by imag value
temp = -j.*Pdig;
temp2 = sort([temp(:,1);temp(:,2)],'ComparisonMethod','real');
Pdig_sort = j.*temp2;
clear temp temp2;

% create 2nd order real systems to cascade
I = length(Pdig);
for i = 1:I
    Pdig_2Order(i,:) = poly([Pdig_sort(2*i-1,1),Pdig_sort(2*i,1)]);
end

%Bd = poly(Zdig(:)'); 
%Ad = poly(Pdig(:)');
%disp(Bd'); disp(Ad');
Omega = linspace(0,pi,100001); H = 1;
% evaluate all 2nd order Zero polynomials over 0->Pi
for i = 1:length(Zdig_2Order)
    H = H .* polyval(Zdig_2Order(i,:),exp(1j*Omega));
end
% evaluate all 2nd order Pole polynomials over 0->Pi
for i = 1:length(Pdig_2Order)
    H = H ./ polyval(Pdig_2Order(i,:),exp(1j*Omega));
end
% multiply by gain factor
H = H .* B(1)/A(1)*prod(1/c2-zk)/prod(1/c2-pk);
fig2 = figure();
subplot(2,1,1);
plot(Omega/T,abs(H),'k-'); axis([0 pi/T -0.05 1.05]);

subplot(2,1,2);
plot(Omega/T,20*log10(abs(H)),'k-'); 

fig3 = figure();
plot(real(Zdig(:)),imag(Zdig(:)),'bo'); hold on;
plot(real(Pdig(:)),imag(Pdig(:)),'rx'); hold on;

plot(real(exp(j.*[0:0.001:2*pi])),imag(exp(j.*[0:0.001:2*pi])),'k');

title("P/Z Plot of Discrete-Time Bandpass Inverse Chebyshev Filter");
grid on; axis([-1 1 -1 1]); xlabel("");








