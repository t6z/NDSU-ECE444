close all % closes all open figures

f = [12,21,32]; % different f0 from problem
f_a = [-8,1,-8];
t = 0:0.001:1; 
t_s = 0:0.05:1; % times that get sampled
for k = 1:3
    subplot(3,1,k);
    x = @(t) sin(2*pi*f(k).*t); % create anonymous function of frequency F0
    plot(t,x(t),'k'); hold on; stem(t_s,x(t_s),'b');
    title("Actual x(t) vs sampled x(t) with apparent frequency " + f_a(k) +"Hz");
end






