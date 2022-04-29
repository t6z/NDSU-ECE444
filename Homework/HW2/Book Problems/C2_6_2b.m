
H = @(s) s.^3 ./ (s.^3 + 2.*s.^2 + 2.*s + 1);

w = -6:0.001:6;
s_a = j.*w;
s_b = 6.2637 ./ (s_a);
s_c = 1.2527 .* (s_a.^2 + 12) ./ (s_a);

subplot(221); plot(w,abs(H(s_a)),'k'); yline(0.8913,'r'); xline(2,'b'); xline(-2,'b');
title("Magnitude Resp. of H"); xlabel("frequency (rad/sec)");

subplot(223); plot(w,abs(H(s_b)),'k'); yline(0.8913,'r'); xline(5,'b'); xline(-5,'b');
title("Magnitude Resp. of LtH(H)"); xlabel("frequency (rad/sec)");

subplot(222); plot(w,abs(H(s_c)),'k'); yline(0.8913,'r'); 
xline(3,'b'); xline(4,'b'); xline(-3,'b'); xline(-4,'b');
title("Magnitude Resp. of LtBP(H)"); xlabel("frequency (rad/sec)");





