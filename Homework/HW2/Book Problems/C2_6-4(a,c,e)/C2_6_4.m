gate = @(w) (abs(w) < 0.5) + (0.5).*(abs(w) == 0.5); 

H_p = @(w) gate((w+1)./2);
w = -6:0.01:6;
w_c = 2./-w;
w_e = (w.*2)./(-w.^2+8);

subplot(221); plot(w,abs(H_p(w)),'k'); title("Magnitude Resp of H_p(w)");
subplot(222); plot(w,abs(H_p(w_c)),'k'); title("Magnitude Resp of LtH(H_p(w))"); axis([-5 5 -0.1 1.1]);
subplot(223); plot(w,abs(H_p(w_e)),'k'); title("Magnitude Resp of LtBS(H_p(w))"); axis([-5 5 -0.1 1.1]);

