function X=fft_stage(x)
  N=length(x);
  X=zeros(1,N);
    if N==2
    X(1)=x(1)+x(2);
    X(2)=x(1)-x(2);

    else
        x0=x(1:2:N);
        x1=x(2:2:N);
        X0=fft_stage(x0);
        X1=fft_stage(x1);
        W=exp(-1j*2*pi.*(0:N/2-1)/N);
        X(1:N/2)=X0+W.*X1;
        X(N/2+1:N)=X0-W.*X1;
    end
end