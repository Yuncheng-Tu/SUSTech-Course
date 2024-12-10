% (2.5) y3[n]=y3[n-1]+(x[n]-x[n-3])/3
%set the initial values of the "value" vector to 0 (for the days prior to the start of data collection)
function y=filter_2_5(x)
N=length(x);
y=zeros(1,N+1);
x=[zeros(1,3) x]; %set the initial values of the "value" vector to 0
for n=2:N+1%matlab索引从1开始
    y(n)=y(n-1)+(1/3)*(x(n+2)-x(n-1));%x(n+3)-x(n)instead of x(n)-x(n-3)
end
y=y(2:N+1);
end