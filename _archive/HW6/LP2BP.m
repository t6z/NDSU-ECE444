figure()
w0 = 1;
w1 = 10;
w2 = 20;

w = 0:0.01:50;
s = j.*w;
Hlp = @(s) 1 ./ ( (s-1) .* (s-4) );
lp2bp = @(s) w0 .* (s.^2 + w1*w2) ./ (s.*(w2-w1));
Hbp = @(s) Hlp(lp2bp(s));

subplot(211);
plot(w,abs(Hlp(s)),'k');
xline(1,'r'); xline(4,'r');

subplot(212);
plot(w,abs(Hbp(s)),'k');