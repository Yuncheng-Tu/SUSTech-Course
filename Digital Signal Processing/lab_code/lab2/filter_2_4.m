
%(2.4) y2[n]=0.8*y2[n-1]+0.2*x[n]
%When you apply the filter of (2.4) you will need to initialize the value of avgvalue(yesterday). Use an initial value of 0.
function y=filter_2_4(x)
N=length(x);
y=zeros(1,N+1);%initialize the value of avgvalue(yesterday)
for n=2:N+1
y(n)=0.8*y(n-1)+0.2*x(n-1);%matlab索引是从1开始，并且这里Y第一位补了个0
end
y=y(2:N+1);
end