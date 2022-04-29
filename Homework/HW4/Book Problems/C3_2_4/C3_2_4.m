%% part a
close all
triangle = @(t) (1-2.*abs(t)).*(abs(t) <= 0.5);
x = @(t) cos(2*pi*t);
t = 0:0.01:1; 
T = [0.5 0.2 0.1];
for k = 1:3
    xhatN = 0; 
    for n = -10:10
        xhatN = xhatN + x(n*T(k))*triangle((t-n*T(k))/(2*T(k)));
    end
    subplot(3,1,k);
    plot(t,x(t),'k'); hold on; plot(t,xhatN,'b');
    title("x(t) vs. interpolated singal of FOH filter with Ts = " + T(k) + "s");
    dt = t(2)-t(1); RMSerror = sqrt(sum((xhatN-x(t)).^2)*dt);
    RMSerror
end

%% part b
close all
T = 1;
unit_gate = @(w) (abs(w) < 0.5) + 0.5.*(abs(w) == 0.5);
% H{1} = ideal, H{2} = ZOH, H{3} = FOH
H = {@(w) T.*unit_gate((w.*T)./(2*pi)); ...
    @(w) T.*sinc((w.*T)./(2*pi)); ...
    @(w) T.*(sinc((w.*T)./(2*pi))).^2 };
name = ["Ideal Interpolation Filter"; "Zero Order Hold"; "First Order Hold"];
w = -10:0.01:10;

for k = 1:3
    subplot(3,2,2*k-1);
    plot(w,abs(H{k}(w)),'k'); xlabel("frequency (rad/sec)");
    title("Magnitude Response of " + name{k});
    
    subplot(3,2,2*k);
    plot(w,angle(H{k}(w)),'k'); xlabel("frequency (rad/sec)");
    title("Frequency Response of " + name{k});
end

%% part c
close all
T = 1;
triangle = @(t) (1-2.*abs(t)).*(abs(t) <= 0.5);
t = -2:0.1:2;

subplot(2,1,1);
plot(t,triangle(t./(2*T)),'k'); title("Impulse Response of h(t)");
axis([-2 2 0 1]);
subplot(2,1,2);
plot(t+T,triangle(t./(2*T)),'k'); title("Impulse Response h(t) by T");
axis([-2 2 0 1]);

%% part c part 2
close all
triangle = @(t) (1-2.*abs(t)).*(abs(t) <= 0.5);
x = @(t) cos(2*pi*t);
t = 0:0.01:1; 
T = [0.5 0.2 0.1];
for k = 1:3
    xhatN = 0; 
    for n = -10:10
        xhatN = xhatN + x(n*T(k))*triangle((t-T(k)-n*T(k))/(2*T(k)));
    end
    subplot(3,1,k);
    plot(t,x(t),'k'); hold on; plot(t,xhatN,'b');
    title("x(t) vs. interpolated singal of FOH filter with Ts = " + T(k) + "s");
    dt = t(2)-t(1); RMSerror = sqrt(sum((xhatN-x(t)).^2)*dt);
    RMSerror
end

%% part d
close all
triangle = @(t) (1-2.*abs(t)).*(abs(t) <= 0.5);
x = @(t) cos(2*pi*t);
t = 0:0.01:1; 
T = [0.5 0.2 0.1];
for k = 1:3
    xhatN = 0; 
    for n = -10:10
        xhatN = xhatN + x(n*T(k))*T(k)*triangle((t-T(k)-n*T(k))/(2*T(k)));
    end
    subplot(3,1,k);
    plot(t,x(t),'k'); hold on; plot(t,xhatN,'b');
    title("x(t) vs. interpolated signal of cascaded ZOH filters with Ts = " + T(k) + "s");
    dt = t(2)-t(1); RMSerror = sqrt(sum((xhatN-x(t)).^2)*dt);
    RMSerror
end
