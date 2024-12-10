function X=FFT4(x)
x0=[x(1) x(3)];%even
x1=[x(2) x(4)];%odd
X0=FFT2(x0);
X1=FFT2(x1);
W=exp(-1j*2*pi.*(0:1)/4);
X=zeros(1,4);
X(1:2)=X0+W.*X1;
X(3:4)=X0-W.*X1;
end