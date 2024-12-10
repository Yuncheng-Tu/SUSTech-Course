function I=integ1(N)
delta=2*pi/(N+1);
f=@(x)(sin(5*x)).^2;
t=linspace(0,2*pi,(N+1));%%创建一个由区间 [0,2pi] 中的 N+1 个等间距点组成的向量。
y=f(t);
area=y*delta;
I=sum(area)
    
    
    