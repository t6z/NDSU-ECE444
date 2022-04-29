% Thomas Smallarz
% ECE444
% HW2 Q4
% 18 Sept 2020

% For each of the following transfer functions, determine and plot the
% poles and zeros of H(s), and use the pole and zero information to
% predict overall system behavior. Conﬁrm your predictions by graphing
% the system’s frequency response (magnitude and phase).

%                  0.03s^4+1.76s^2+15.22
%  (c) H(s) = _______________________________
%              s4+2.32s3+9.79s2+13.11s+17.08

num = [0.03 0 1.76 0 15.22];
den = [1 2.32 9.79 13.11 17.08];

H = tf(num,den);
Hp = pole(H)
Hz = zero(H)

subplot(2,2,1);
pzplot(H,'r'); axis([-1 1 -8 8]);

w = -10:0.01:10;
s = j*w;
H = (0.03.*s.^4 + 1.76.*s.^2 + 15.22) ./ (s.^4 + 2.32.*s.^3 + 9.79.*s.^2 + 13.11.*s + 17.08);
subplot(2,2,3);
plot(w,abs(H)); title("Magnitude Response"); xlabel("frequency (rad/sec)"); ylabel("|H|");
yline(1/sqrt(2));
subplot(2,2,4);
plot(w,angle(H)); title("Phase Response"); xlabel("frequency (rad/sec)"); ylabel("angle(H) (radians)");

d_H_ang = diff(angle(H)) ./ 0.01;
w_new = w; w_new(end) = [];




