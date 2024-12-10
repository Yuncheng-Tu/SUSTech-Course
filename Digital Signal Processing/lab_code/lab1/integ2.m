function J=integ2(N)
delta=1/(N+1);
f=@(x)exp(x);
t=linspace(0,1,(N+1));
y=f(t);
area=y*delta;
J=sum(area);
    
    
    