function [mag,phase] = FreRes(num,den)

M = length(num);
N = length(den);

nP = 0:-1:-M+1;%分子指数系数Z^0,Z^-1，Z^-2
nD = 0:-1:-N+1;

syms w;
Pz = sum(num.*exp(j*w).^nP);%当|z|=1，z=e^jw
Dz = sum(den.*exp(j*w).^nD);
Hz = Pz/Dz;

mag = abs(Hz); 
phase = angle(Hz); 
end

