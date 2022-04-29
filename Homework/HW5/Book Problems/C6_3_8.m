H = @(W,T) (T/2).*( ( 1 + exp(-j.*W) ) ./ ( 1 - exp(-j.*W) ) ) .* (W~=0);
W = -pi:0.025:pi;
T = 1;
subplot(421); plot(W,abs(H(W,T)),'k'); title("Magnitude Response for H(\Omega)");
xlabel("\Omega"); ylabel("|H(\Omega)|");

subplot(422); plot(W,angle(H(W,T)),'k'); title("Phase Response for H(\Omega)");
xlabel("\Omega"); ylabel("\angleH(\Omega)");

delta = @(w) (w<=0.001 & w>=-0.001);
Ta = 20*pi;
Xa = @(W) pi.*(delta(W-0.1) + delta(W+0.1));
Ya = @(W) Xa(W) .* H(W,Ta);
Wa = -pi:0.00001:pi;

Tb = 12;
Xb = @(W) (pi/j).*(delta(W-(pi/6)) - delta(W+(pi/6)));
Yb = @(W) Xb(W) .* H(W,Tb);
Wb = -pi:0.00001:pi;

Tc = 4;
Xc = @(W) pi.*(delta(W-(pi/2)) + delta(W+(pi/2)));
Yc = @(W) Xc(W) .* H(W,Tc);
Wc = -pi:0.00001:pi;

subplot(423); plot(Wa,abs(Ya(Wa)),'k'); title("Magnitude Response for Y_a(\Omega)");
xlabel("\Omega"); ylabel("|Y_a(\Omega)|"); axis tight;

subplot(424); plot(Wa,angle(Ya(Wa)),'k'); title("Phase Response for Y_a(\Omega)");
xlabel("\Omega"); ylabel("\angleY_a(\Omega)"); axis tight;

subplot(425); plot(Wb,abs(Yb(Wb)),'k'); title("Magnitude Response for Y_b(\Omega)");
xlabel("\Omega"); ylabel("|Y_b(\Omega)|"); axis tight;

subplot(426); plot(Wb,angle(Yb(Wb)),'k'); title("Phase Response for Y_b(\Omega)");
xlabel("\Omega"); ylabel("\angleY_b(\Omega)"); axis tight;

subplot(427); plot(Wc,abs(Yc(Wc)),'k'); title("Magnitude Response for Y_c(\Omega)");
xlabel("\Omega"); ylabel("|Y_c(\Omega)|"); axis tight;

subplot(428); plot(Wc,angle(Yc(Wc)),'k'); title("Phase Response for Y_c(\Omega)");
xlabel("\Omega"); ylabel("\angleY_c(\Omega)"); axis tight;