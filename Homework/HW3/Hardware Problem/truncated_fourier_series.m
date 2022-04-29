% ECE444 Fall 2020
% Homework 3 Problem 5
% Student ID: 1148496
%% Part A
A = 9;
B = 6;

t = -20:0.1:20;
x = (-t ./ (B+10)).*( -(B+10) <= t & t < 0 ) ...
    + (2.*t./(A+10)).*(0 <= t & t < (A+10));

subplot(211);
for k = 0:1
    plot(t+40.*k,x,'k'); hold on;
end
xlabel("t"); ylabel("x(t)");

%% Part B
% y(t) = c1 + c2*x(c3*t)
% c1 is offset, c2 is gain 
% Output range of K22F DAC is 0->3.3V
x_min = min(x); x_max = max(x);

DAC_max = 3.3;
DAC_nbits = 12;
bit_step = DAC_max / (2^DAC_nbits);

percent_buffer = 0.01;

DAC_buff_min = percent_buffer * DAC_max;
DAC_buff_max = (1-percent_buffer) * DAC_max;

c1 = DAC_buff_min - x_min;
c2 = DAC_buff_max / (x_max + c1);

subplot(212);
for k = 0:1
    plot(t+40.*k,c1 + c2.*x,'k'); hold on;
end
axis([-22 62 0 3.3]);




