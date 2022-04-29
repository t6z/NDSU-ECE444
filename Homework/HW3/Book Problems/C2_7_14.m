% Inverse Chebyshev Filter
% Determine transfer function H(s)
% Plot Mag. and Phase Responses
% for a third-order lowpas Inverse Chebyshev Filter
% if the 3dB cutoff frequency is 100 rad/sec and 
% the stopband ripple is limited to 20dB

% Using Example 2.16 starting on page 141 in book:
K = 3; % Order of filter
wc = 100; % 3dB cutoff frequency (rad/sec)
sb_ripple = 20; % 20dB stop band ripple
E = sqrt(abs(inv(10^(sb_ripple/10) - 1))); % stop band ripple parameter
k = 1:K;

ws = wc*cos( acos(1/E) / K);

hyp_inside = asinh(1/E) / K;
reg_inside = (pi.*(2.*k - 1) ./ (2*K));

pk = 1./( (-1/ws).*sinh(hyp_inside).*sin(reg_inside) + (j/ws).*cosh(hyp_inside).*cos(reg_inside));

zk = j.*ws.*sec( (pi.*(2.*k-1)) ./ (2*K));
Gain = 1;
for m = 1:K
   Gain = Gain * (pk(1,m) / zk(1,m));    
end

H = @(s) Gain .* ( (s - zk(1,1)).*(s - zk(1,2)).*(s - zk(1,3))) ...
    ./ ( (s - pk(1,1)) .* (s - pk(1,2)) .* (s - pk(1,3)));

w = 0:0.1:200;
s = j.*w;
subplot(2,1,1);
plot(w,abs(H(s)),'k'); yline(1/sqrt(2),'r'); xline(100,'r');
xlabel("frequency (rad/s)"); title("magnitude response of LP Inv. Chebyshev");

subplot(2,1,2);
plot(w,angle(H(s)),'k');
xlabel("frequency (rad/s)"); title("phase response of LP Inv. Chebyshev");
