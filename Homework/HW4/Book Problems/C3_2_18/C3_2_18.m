delta = @(t) (t<0.001 & t>-0.001);

X = @(f) 0.5.*(delta(f-0.6) + delta(f+0.6) + delta(f-0.1) + delta(f+0.1));
f = -1:0.001:1;
plot(f,X(f));

f = -

