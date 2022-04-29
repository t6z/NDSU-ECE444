% define Triangle Gate model function
triangle = @(t) (1 - 2.*abs(t)) .* ( abs(t) <= 0.5);
sinc_ = @(t) sin(pi.*t) ./ (pi.*t);
% define delta function
delta = @(t) 1.*(t < 0.001 & t > -0.001);

x = @(t) sin(2*pi.*t);
T = 0.1;

% t = 0:0.01:1;
% x_s = zeros(size(t));
% for n = -10:10
%     x_s = x_s + x(t) .* delta(t-n*T);
% end
% 
% subplot(5,1,1); plot(t,x(t),'k'); hold on;
% stem(t,x_s,'b'); xlabel("t"); title("x(t) vs sampled x(t)");
% 
% % use f instead of w so its easier to plot
% 
% X = @(f) (pi / j) .* ( delta(f - 1) - delta(f + 1) );
% subplot(5,1,2); plot(f,abs(X(f)),'k'); axis([-1.5 1.5 -0.1 pi+0.2]);
% xlabel("frequency (Hz)"); title("X(w)");



t2 = (-2:0.01:2);
h = triangle(t2 ./ 2);
subplot(3,1,1); plot(t2,h,'k'); xlabel("t"); title("h(t)");

f = -3:0.01:3;
H = @(f) (sinc_(f)).^2;
subplot(3,1,2); plot(f,H(f),'k'); xlabel("frequency (Hz)"); title("X(w)");



