% ECE 444 HW6
% Fall 2020
% Thomas Smallarz
format short; close all; clear variables;
%% Design Low-Pass Inverse Chebyshev Prototype Filter with normalized freq
% Based on Ex. 2.17
K = 10;
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
