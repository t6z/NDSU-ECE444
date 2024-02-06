omegap1 = 100; omegap2 = 250; omegas1 = 40; omegas2 = 500; omegap = 1;
omegas = abs([omegap*(omegas1^2-omegap1*omegap2)/(omegas1*(omegap2-omegap1)),...
            omegap*(omegas2^2-omegap1*omegap2)/(omegas2*(omegap2-omegap1))])
        
omegas = min(omegas); alphap = 3; alphas = 17;
K = ceil(log((10^(alphas/10)-1)/(10^(alphap/10)-1))/(2*log(omegas/omegap)))

omegac = [omegap/(10^(alphap/10)-1).^(1/(2*K)),omegas/(10^(alphas/10)-1).^(1/(2*K))]

omegac = mean(omegac); k = 1:K;
pk = (1j*omegac*exp(1j*pi/(2*K)*(2*k-1))); A = poly(pk)

H_lp = @(s) A(1,3) ./ ( A(1,1).*s.^2 + A(1,2).*s + A(1,3));

w = 0:0.1:650; s = j.*w;
s2 = omegap .* ( (s.^2 + omegap1*omegap2) ./ (s.*(omegap2 - omegap1)));

plot(w,abs(H_lp(s2)),'k'); xlabel("Frequency (rad/sec)"); ylabel("Gain");
title("Magnitude Response of Band-pass filter");
rectangle('Position',[100 0 150 0.7071],'FaceColor','red');
rectangle('Position',[500 0.14125 150 (1-0.14125)],'FaceColor','red');
rectangle('Position',[0 0.14125 40 (1-0.14125)],'FaceColor','red'); 

