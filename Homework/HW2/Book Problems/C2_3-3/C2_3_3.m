% Thomas Smallarz
% ECE444 Homework 2
% Fall 2020

% Essentials of Digital Signal Proscessing
% Problem 2.3-3
step = 100;
w = -1e7/2:step:1e7/2; s = j.*w;
H = @(s) (s.*1e-6 + 1).^(-1);

subplot(3,2,1); plot(w,abs(H(s)),'k'); title("Mag Resp of H"); xlabel("rad/sec");
xline(1e6,'--r'); xline(-1e6,'--r'); yline(1/sqrt(2),'--b');
subplot(3,2,2); plot(w,angle(H(s)),'k'); title("Phase Resp of H"); xlabel("rad/sec");
xline(1e6,'--r'); xline(-1e6,'--r'); hold on; plot(w,y(w),'r'); xline(0,'k'); yline(0,'k');

w2 = -1e6:step:1e6; s2 = j.*w2;

subplot(3,2,3); plot(w2,abs(H(s2)),'k'); title("Zoomed in Mag Resp of H"); xlabel("rad/sec");
xline(1e6,'--r'); xline(-1e6,'--r'); yline(1/sqrt(2),'--b'); axis([(-1e6-100000) (1e6+100000) 0.680 1.02]);


subplot(3,2,4); plot(w2,angle(H(s2)),'k'); title("Zoomed in Phase Resp of H"); xlabel("rad/sec");
xline(1e6,'--r'); xline(-1e6,'--r'); axis([(-1e6-100000) (1e6+100000) -1 1]);


tg = -diff(angle(H(s2)))./step;
w2_new = w2; w2_new(end) = [];
subplot(3,2,5); plot(w2_new,tg,'k'); title("Delay Variation of H"); xline(1e6); xline(-1e6); xlabel("rad/sec");

w3 = -1e7:step:1e7; s3 = j.*w3;
tg = -diff(angle(H(s3)))./step;
w3_new = w3; w3_new(end)=[];
subplot(3,2,6); plot(w3_new,tg,'k'); title("Delay Variation of H"); xline(3e6); xline(-3e6); xlabel("rad/sec");

y = @(x) -0.0000001.*(x-3000000) - 1.249;










