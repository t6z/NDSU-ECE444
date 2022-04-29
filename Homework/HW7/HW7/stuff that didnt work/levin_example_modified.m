% Complex Least Squares FIR filter design using Levinson's algorithm
%
% h      filter impulse response
% N      filter length
% om     frequency grid (0 <= om <= pi)
% D      complex desired frequency response on the grid om
% W      positive weighting function on the grid om

% example: length 61 bandpass, band edges [.23,.3,.5,.57]*pi,
% weighting 1 in passband and 10 in stopbands, desired passband
% group delay 20 samples
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
[minValue,closestIndex] = min(abs(data(:,1) - cutoff_freq));
if(data(closestIndex,1) > cutoff_freq)
    closestIndex = closestIndex - 1; 
end
data_cutoff = data([1:closestIndex],:);

% make any data above nyquist frequency zero except for frequency
%eval(labels(1) + " = data_cutoff(:,1);");

% [minValue,closestIndex] = min(abs(data(:,1) - cutoff_freq));
% if(data(closestIndex,1) > cutoff_freq)
%     closestIndex = closestIndex - 1; 
% end
% data_cutoff(closestIndex+1:end,:) = 0;

clear closestIndex minValue;

% creating variables with necessary data (except for frequency...)
eval(labels(1) + " = data_cutoff(:,1);");
data_needed = [4 5 6];
for i = data_needed
   eval(labels(i) + " = db2mag(data_cutoff(:,i));");    
end

clear data data_cutoff data_needed labels;

om=frequency'*2*pi*T;
D= equalization';
W= ones(1,length(D));
h = lslevin(40,om,D,W);

figure(); subplot(311); plot(abs(D),'k');
subplot(312); plot(linspace(0,1,length(h)).*pi,abs(fft(h)));
subplot(313); plot(unwrap(angle(fft(h))));
figure(); stem(h);
