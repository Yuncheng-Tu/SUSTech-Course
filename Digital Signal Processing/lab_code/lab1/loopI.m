function y=I(N)
y=zeros(1,N);
for i=1:N
    y(i)=integ1(i);
end
  
