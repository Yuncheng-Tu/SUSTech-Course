
function X = dcDFT(x)
N = length(x);  % Even 
x0 = x(1:2:N);  % Even part of input: x[0],x[2],...,x[N-2]
x1 = x(2:2:N);  % Odd part of input: x[1],x[3],...,x[N-1]
X0 = DFTsum(x0); 
X1 = DFTsum(x1); 
W=exp(-1j*2*pi*(0:N/2-1)/N);%twiddle factors;
X=zeros(1,N);
X(1:N/2)=X0+W.*X1;
X(N/2+1:N)=X0-W.*X1;
end