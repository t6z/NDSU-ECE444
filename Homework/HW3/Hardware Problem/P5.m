% ECE444 Fall 2020
% Homework 3 Problem 5
% Student ID: 1148496
%% Part A
A = 9;
B = 6;

t = -20:0.001:20;
x = @(t) (-t ./ (B+10)).*( -(B+10) <= t & t < 0 ) ...
    + (2.*t./(A+10)).*(0 <= t & t < (A+10));

x_init = x(t);
subplot(311);
for k = 0:1
    plot(t+40.*k,x_init,'k'); hold on;
end
xlabel("t"); ylabel("x(t)");

%% Part B
% y(t) = c1 + c2*x(c3*t)
% c1 is offset, c2 is gain 
% Output range of K22F DAC is 0->3.3V
DAC_max = 4095;
percent_os = 0.12; % percent of overshoot expected (Gibbs Phen.)

x_top_new = floor(DAC_max / (2*(1+percent_os)) + DAC_max / 2);
x_bot_new = DAC_max - x_top_new;

c1 = x_bot_new;
c2 = (x_top_new - x_bot_new) / max(x_init);

x2 = c1 + c2.*x_init;
subplot(312);
for k = 0:1
    plot(t+40.*k,x2,'k'); hold on;
end
ylabel("x_2(t)"); xlabel("t");

%% Part C
T_DAC = 0.0001;
T_x_init = 40;
N_outputs_per_period = 4;
c3 = T_x_init / (10 * T_DAC * N_outputs_per_period);

t = -0.002:0.0000001:0.002;
t3 = @(t) c1 + c2.*x(c3.*t);
subplot(313);
for k = 0:1
    plot(t+40.*k./c3,t3(t),'k');
    hold on;
end
 ylabel("x_3(t)"); xlabel("t");
 
 
 %% Part D
 K = -10:10;

 T0 = 40;
 T3 = T0 / c3;
 f0 = 1 / T0;
 f3 = f0 * c3;
 w0 = 2*pi*f0;
 w3 = 2*pi*f3;
 
 %A_ = @(k) (c1 / T3) .* ( (exp((-j).*k.*w0.*(A+10)) - exp((-j).*k.*w0.*(-B-10)) ) ./ ((-j).*k.*w3) );
%  A_ = @(k) (c1 / T3) .* ( (exp((-j).*k.*pi) - exp(j.*k.*pi)) ./ ((-j).*k.*w3) );
%  
%  B1 = @(k) (2 / (A + 10)) .* ( (j.*k.*w0.*(A+10).*exp( (-j).*k.*w0.*(A+10) ) + ...
%      exp( (-j).*k.*w0.*(A+10) ) ) ./ (k.^2 .* w3.^2));
%  
%  B2 = @(k) (1 / (B + 10)) .* ( (j.*k.*w0.*(-B-10).*exp( (-j).*k.*w0.*(-B-10)) + ...
%      exp( (-j).*k.*w0.*(-B-10))) ./ (k.^2 .* w3.^2));
%  
%  B_ = @(k) (c2 / T3) .* ( B1(k) + B2(k) );
 
B1 = @(k) (-1/(B+10)).*(  ( (1-exp(j.*k.*w0.*(B+10)))./((k.^2).*(w3.^2)) )  ...
    + j.*( ((B+10).*exp(j.*k.*w0.*(B+10)))./(k.*c3.*w3) ) );

B2 = @(k) (2/(A+10)).*( ((exp(-j.*k.*w0.*(A+10))-1)./((k.^2).*(w3.^2))) ...
    + j.*( ((A+10).*exp(-j.*k.*w0.*(A+10)))./(k.*c3.*w3)) );

B_ = @(k) (c2 / T3) .* (B1(k) + B2(k));

Yk = B_(K);
%Yk(1,11) = 1511.7075;
 
f2 = figure();
 
t3 = (-20:0.001:20) ./ c3;
x_FS = zeros(size(t3));
for K = -9:9
    if (K>0 || K<0)
        x_FS = x_FS + B_(K).*c3.*exp(j.*K.*w3.*t3);
    end
    
    if K==0
        x_FS = x_FS + 1511.7075;
    end
end
x_FS = x_FS + 100;
plot(t2,x_FS)
 
% subplot(221); plot(K,abs(Yk(K)));
 
 
 
 
 
 
 
 
 
 
 
 
 

