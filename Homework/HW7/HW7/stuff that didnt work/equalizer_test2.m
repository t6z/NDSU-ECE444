% ECE444 HW7
% FIR Equalizer using Frequency Weighted Least Squares method
% Thomas Smallarz
% Fall 2020

clear variables; close all;
Fs = 20e3; T = 1 / Fs;
cutoff_freq = 10e3; % 10kHz cutoff due to 20kHz fixed sampling rate
Lh = 20;

% Label Definitions:
% in_raw: Raw input measured
% in_smoothed: Smoothed input measured
% target: Target (expected) input
% error_raw: Raw error (target - in_raw)
% error_smoothed: Smoothed error smooth(target - in_raw)
% equalization: inverse of error_smoothed removing peaks above +6dB

% ***********************************************
% ***** Importing and manipulating data.xls *****
% ***********************************************
% import data from .xls file
opts = detectImportOptions("data.xls");
labels = opts.VariableNames;
data = readmatrix("data.xls");
clear opts;

% cutoff any data that is above sampling frequency
[minValue,closestIndex] = min(abs(data(:,1) - Fs));
if(data(closestIndex,1) > Fs)
    closestIndex = closestIndex - 1; 
end
data_cutoff = data([1:closestIndex],:);

% make any data above nyquist frequency zero except for frequency
eval(labels(1) + " = data_cutoff(:,1);");

[minValue,closestIndex] = min(abs(data(:,1) - cutoff_freq));
if(data(closestIndex,1) > cutoff_freq)
    closestIndex = closestIndex - 1; 
end
data_cutoff(closestIndex+1:end,:) = 0;

clear closestIndex minValue;

% creating variables with necessary data (except for frequency...)
eval(labels(1) + " = data_cutoff(:,1);");
data_needed = [4 5 6];
for i = data_needed
   eval(labels(i) + " = db2mag(data_cutoff(:,i));");    
end

clear data data_cutoff data_needed labels;

% *************************************
% ***** Plotting desired response *****
% *************************************
figure(); semilogx(frequency, mag2db(equalization), 'k');
grid on; ylabel("Gain (dB)"); xlabel("Frequency (Hz)");
title("HyperX Cloud II desired normalization frequency response");

% ********************************************
% ***** Creating Q(k) Weighting Function *****
% ********************************************
Omegak = frequency'*2*pi*T;
K = length(Omegak);
Q = ones(1,length(equalization));
Q(fix(K/2)+2:end) = Q(round(K/2):-1:2);

% *****************************************
% ***** Calculating a and b matricies *****
% *****************************************


l = (0:Lh-1)';

a = exp(1j*l*Omegak)*Q.'/K;
%equalization(fix(K/2)+2:end) = conj(equalization(round(K/2):-1:2));
equalization = equalization';
b = exp(1j*l*Omegak)*(equalization.*Q/K).';

%a = zeros(length(Lh)); b = zeros(length(Lh));
%a = exp(1j*l*Omegak)./K;
%b = equalization .* exp(1j*l*Omegak) ./ K;
% for l = 1:Lh
%    a(l) = sum( exp(j*(l-1).*Omegak) ) ./ K;
%    b(l) = sum( equalization .* exp(j*(l-1).*Omegak) ) ./ K;
% end

A = toeplitz(a); 
h = (A\b);

%H = polyval(h,exp(j*Omegak)) .* exp(-j*(Lh-1)*Omegak);
%figure(); semilogx(frequency, abs(H),'k');

