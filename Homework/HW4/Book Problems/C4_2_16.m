x = @(t) 10.*cos(2000*pi.*t) + sqrt(2).*sin(3000*pi.*t) + 2.*cos(5000*pi.*t + pi/4);
T0 = 1 / 500;
t = 0:0.000001:0.01;

plot(t,x(t));
for k = 0:4
    xline(k.*T0);
end