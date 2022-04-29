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
om=pi*[linspace(0,.23,230),linspace(.3,.5,200),linspace(.57,1,430)];
D=[zeros(1,230),abs(om(231:430)).*exp(-j*om(231:430)*20),zeros(1,430)];
W=[10*ones(1,230),ones(1,200),10*ones(1,430)];
h = lslevin(61,om,D,W);

