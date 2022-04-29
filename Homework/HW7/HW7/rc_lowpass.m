% first stage RC lowpass filter... could help with aliasing
% maybe take the inverse of this filter at our freq points?
R = 3e4;
C = 1.5e-9;
w = linspace(0,20e3*2*pi,1e3);
s =  j.*w;
Hrc = 1 ./ (s.*C*R + 1);

figure(); subplot(211);
plot(w/(2*pi),abs(Hrc),'k');
title("RC Filter with R = " + num2str(R) + "\Omega and C = " + num2str(C) + "F");
xlabel("freq (Hz)"); xline(10000,'r');
ylabel("gain (ratio)"); yline(1/sqrt(2),'r');
text(0.6*max(w./(2*pi)),0.9,"Cutoff freq = " + num2str(1 / (2*pi*R*C)) + "Hz");

subplot(212);
plot(w/(2*pi),unwrap(angle(Hrc)),'k');


