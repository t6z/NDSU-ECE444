% [b,a] = residue([1 2], [0.9 -0.3],[])

% H = @(z) z ./ (z-0.9) + 2.*z./(z+0.3);
% omega = 0:0.01:2*pi;
% z = exp(-j.*omega);
% plot(omega, abs(H(z)),'k');
u = @(n) (n>=0);
h = @(n) (0.9).^n.*u(n) + 2.*(-0.3).^n.*u(n);
x = @(n) (0.9).^n.*u(n) + (-0.3).^n.*u(n);
y = @(n) (n+1).*(0.9).^n.*u(n) + 2.*(n+1).*(-0.3).^n.*u(n) ...
    + 3.* ( (-0.3).^(n+1) - (0.9).^(n+1) ) ./ (-1.2) .* u(n);
n = -1:45;

subplot(131);
stem(n,x(n),'k'); xlabel("n"); ylabel("x[n]");

subplot(132);
stem(n,h(n),'k'); xlabel("n"); ylabel("h[n]");

subplot(133);
stem(n,y(n),'k'); xlabel("n"); ylabel("y[n]");








