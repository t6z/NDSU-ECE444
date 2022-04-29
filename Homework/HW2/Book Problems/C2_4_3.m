% Thomas Smallarz
% ECE444 Homework 2
% Fall 2020
% 
% Essentials of Digital Signal Proscessing
% Problem 2.4-3

% For each of the following windows, determine a suitable width T 
% so that when applied to an ideal LPF with impulse response
% h(t) = (10/pi)*sinc(10*t/pi)
% the resulting transition band is approximately 1 rad/s.

% (a) a rectangular window
% (b) a triangular window
% (c) a Hann window
% (d) a Hamming window
% (e) a Blackman window

% Defining Signal Models
RectWin = @(t) (abs(t) < 0.5);
TriWin = @(t) (1-2*abs(t)) * (abs(t)<=0.5);


% Fourier Transform pair a sinc function with form
% h(t)=(B/pi)sinc(B*t/pi) -> H(w)=rect(w/(2B))




% % % % % % % % % % % % %
%   Rectangular Window  % 
% % % % % % % % % % % % %




