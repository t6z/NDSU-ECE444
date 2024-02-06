step = 0.001;
w = -10:step:10; s = j.*w;
H = (3.*s) ./ (s.^2 + 2.*s + 2);

tg = (-diff(angle(H)))./step;

subplot(2,2,1); plot(w,abs(H)); xlabel("rad/sec"); title("Magnitude Resp. of H"); axis([-6 6 0 1.5]); yline(max(abs(H))/sqrt(2))
subplot(2,2,2); plot(w,angle(H)); xlabel("rad/sec"); title("Phase Resp. of H"); axis([-6 6 -pi/2 pi/2]);

w(end) = [];
subplot(2,2,[3 4]); plot(w,tg); xlabel("rad/sec"); title("Measure of Delay Variation of H");
axis([-6 6 -0.5 1.5]); xline(-2.7,'k'); xline(2.7,'k'); xline(-0.73,'k'); xline(0.73,'k');
