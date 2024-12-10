function X=FFT8(x)
x0=[x(1) x(3) x(5) x(7)];%even
x1=[x(2) x(4) x(6) x(8)];%odd
X0=FFT4(x0);
X1=FFT4(x1);
W=exp(-1j*2*pi*(0:3)/8);
X=zeros(1,8);
X(1:4)=X0+W.*X1;
X(5:8)=X0-W.*X1;
end

