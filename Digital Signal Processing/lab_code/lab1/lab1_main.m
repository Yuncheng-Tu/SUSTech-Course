%% 
% 1.2

a=[1 2 3];
c=a.*a
d=sin(5*c.^2)
%% 
% 1.3.1
% 
% 

clc,clear,close all
syms t
y=sin(5*t.^2)
Sy=int(y,t,0,2*pi)
Z=exp(t)
Sz=int(Z,t,0,1)
%% 
% 1.3.2

clc,clear,close all
n1=0:2:60;
y=sin(n1/6);
subplot(3,1,1)
stem(n1,y)

n1=0:2:60;
z=sin(n1/6);
subplot(3,1,2)
plot(n1,z)

n2=0:10:60;
w=sin(n2/6);
subplot(3,1,3)
plot(n2,w)
%% 
% 1.3.3

clear
N=100;
n1=1:N;
I=loopI(N);
J=J(N);
figure
subplot(2,1,1)
stem(n1,I),title('I(N) 12111008 屠耘诚')
subplot(2,1,2)
stem(n1,J),title('J(N) 12111008 屠耘诚')
%% 
% 可以看见I(5)=I（10）=0
% 
% 1.4
% 
% 1.5
% 
% 

t1=-10*pi:0.1:10*pi;
t2=-2:0.1:2;
sinc=sinc(t1);
rect=(abs(t2)<=0.5);%方波函数

figure
subplot(2,1,1)
plot(t1,sinc),title('sinc 12111008 屠耘诚')
subplot(2,1,2)
plot(t2,rect),title('rect 12111008 屠耘诚')
%% 
% 

clear
n1=-20:20;
y=(n1>=0)-(n1>=10);
%a=0.8
a1=0.8;
y1=a1.^n1.*y;
%a=1.0
a2=1;
y2=a2.^n1.*y;
%a=1.5
a3=1.5;
y3=a3.^n1.*y;
figure
subplot(3,1,1),title('a=0.8 屠耘诚')
stem(n1,y1)
subplot(3,1,2),title('a=1.0 屠耘诚')
stem(n1,y2)
subplot(3,1,3),title('a=1.5 屠耘诚')
stem(n1,y3)


n2=-1:10;
w=pi/4;
y=(n2>=0);

a1=0.8;
y1=cos(w*n2).*(a1.^n2).*y;

a2=1;
y2=cos(w*n2).*(a2.^n2).*y;

a3=1.5;
y3=cos(w*n2).*(a3.^n2).*y;
figure
subplot(3,1,1)
stem(n2,y1),title('a=0.8 屠耘诚')
subplot(3,1,2)
stem(n2,y2),title('a=1.0 屠耘诚')
subplot(3,1,3)
stem(n2,y3),title('a=1.5 屠耘诚')
%% 
% 1.6
% 
% 

Ts1=1/10;
Ts2=1/3;
Ts3=1/2;
Ts4=10/9;

f=@(x) sin(2*pi*x);

n1=0:100;
n2=0:30;
n3=0:20;
n4=0:9;

f1=f(Ts1*n1);
f2=f(Ts2*n2);
f3=f(Ts3*n3);
f4=f(Ts4*n4);

figure
subplot(4,1,1),stem(n1,f1),axis([0,100,-1,1]),title('Ts1')
subplot(4,1,2),stem(n2,f2),axis([0,30,-1,1]),title('Ts2')
subplot(4,1,3),stem(n3,f3),axis([0,20,-1,1]),title('Ts3')
subplot(4,1,4),stem(n4,f4),axis([0,9,-1,1]),title('Ts4')
%% 
% 1.7

clear
sig1=randn(1,1000);% Gaussian random variables with mean 0 and variance 1
sig2=0.2+randn(1,1000);%Gaussian random variables with mean 0.2 and variance 1

figure
subplot(2,1,1),stem(sig1)
subplot(2,1,2),stem(sig2)

ave1=zeros(1,1000);
ave2=zeros(1,1000);
n=1:1000;

for i=1:1000
    ave1(i)=mean(sig1(1:i));
    ave2(i)=mean(sig2(1:i));
end

figure 
plot(n,ave1,n,ave2),title('average')
legend('ave1','ave2')