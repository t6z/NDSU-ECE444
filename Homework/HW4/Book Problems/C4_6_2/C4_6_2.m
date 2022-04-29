x = @(n) cos(pi.*n./5).*(mod(n,1)==0);
L = 2; M = 5; 
xup = @(n) x(n/L); xupdown = @(n) xup(n*M);
xdown = @(n) x(n*M); xdownup = @(n) xdown(n/L);
n = 0:30; subplot(3,2,[1 2]); stem(n,x(n),'k'); title("x[n]");

n = 0:30*L; subplot(323); stem(n,xup(n),'k'); title("x_u_p[n]");
n = 0:30*L/M; subplot(324); stem(n,xupdown(n),'k'); title("x_u_p_d_o_w_n[n]");

n = 0:30/M; subplot(325); stem(n,xdown(n),'k'); title("x_d_o_w_n[n]");
n = 0:30*L/M; subplot(326); stem(n,xdownup(n),'k'); title("x_d_o_w_n_u_p[n]");

