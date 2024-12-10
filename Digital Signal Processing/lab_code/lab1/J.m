function JN=J(N)
JN=zeros(1,N);
for j=1:N
    JN(j)=integ2(j);
end
   
