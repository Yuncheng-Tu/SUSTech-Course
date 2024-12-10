%% 
% 8.2
% 
% (1)

clc;
close all;
clear;
N = 0:20;
rectangular = ones(21,1);
window_hanning = hann(21);
window_hamming = hamming(21);
window_blackm = blackman(21);

[X1,w1] = DTFT(rectangular,512);
[X2,w2] = DTFT(window_hanning,512);
[X3,w3] = DTFT(window_hamming,512);
[X4,w4] = DTFT(window_blackm,512);

H=((2/pi).*sinc((2/pi).*(N-(0.5*(21-1)))))';
w = H.*window_hamming;
[X, W]=DTFT(w, 512);

figure();
subplot(2,2,1);
stem(N,rectangular);
title('Rectangular window');

subplot(2,2,2);
stem(N,window_hanning);
title('Hanning window');

subplot(2,2,3);
stem(N,window_hamming);
title('Hamming window');

subplot(2,2,4);
stem(N,window_blackm);
title('Blackman window');

figure();
subplot(2,2,1);
plot(w1,20*log10(abs(X1)));
title('DTFT of Rectangular window');

subplot(2,2,2);
plot(w2,20*log10(abs(X2)));
title('DTFT of Hanning window');

subplot(2,2,3);
plot(w3,20*log10(abs(X3)));
title('DTFT of Hamming window');

subplot(2,2,4);
plot(w4,20*log10(abs(X4)));
title('DTFT of Blackman window');


%% 
% 


N = 21;
w=hamming(N);
wc= 2.0;
n=0:20;
h_ideal=LPFtrunc(N);

h = w'.*h_ideal;
[H,omega]= DTFT(h,512);

figure
plot(h_ideal),title('h_i_d_e_a_l')

figure
subplot(211),
stem(n,h),title('impulse response h')
subplot(212),
plot(omega,20*log10(abs(H))),title('DTFT magitude H')
% rec mainlobe(th):4pi/21=0.5984 (measured):0.5890
% rec peak-to-sidelobe(th):-13dB (measured):13.2486-26.4444=-13.1958dB

% hanning mainlobe(th):8pi/21=1.1968 (measured):1.2517
% hanning peak-to-sidelobe(th):-32dB (measured):-11.4892-20=-31.4982dB

% hamming mainlobe(th):8pi/21=1.1968 (measured):1.3499
% hamming peak-to-sidelobe(th):-43dB (measured):-20.6983-20.7326=-41.4309dB

% blackman mainlobe(th):12pi/21=1.7952 (measured):1.8899
% blackman peak-to-sidelobe(th):-58dB (measured):-39.7752-18.4856=-58.2608dB

%the result of th and mea very close
%relation:Larger mainlobe widh and smaller peak-to-sidelobe amplitude.
%% 
% 
% 
% 8.3
% 
% (1)


n=0:20;
x1=kaiser(21,0);
x2=kaiser(21,1);
x3=kaiser(21,5);

[X1,w1]=DTFT(x1,512);
[X2,w2]=DTFT(x2,512);
[X3,w3]=DTFT(x3,512);
figure();
subplot(3,2,1);
stem(n,x1);
xlabel('n');
title('kaiser window for beta=0');

subplot(3,2,2);
plot(w1,20*log10(abs(X1)));
xlabel('w/rad');
ylabel('magnitude/dB')
title('magnitude of DTFT for beta=0');

subplot(3,2,3);
stem(n,x2);
xlabel('n');
title('kaiser window for beta=1');

subplot(3,2,4);
plot(w2,20*log10(abs(X2)));
xlabel('w/rad');
ylabel('magnitude/dB')
title('magnitude of DTFT for beta=1');

subplot(3,2,5);
stem(n,x3);
xlabel('n');
title('kaiser window for beta=5');

subplot(3,2,6);
plot(w3,20*log10(abs(X3)));
xlabel('w/rad');
ylabel('magnitude/dB')
title('magnitude of DTFT for beta=5');
%% 
% As _𝛽_ increases, the time domian window becomes no more flat(Two sides of 
% the window decrease.). 
% 
% Moreover, in the frequency domian, main lobe 变宽.

deltas=0.005;
deltap=0.05;
wp=1.8;
ws=2.2;
wc=2.0;

delta=min([deltas,deltap]);%deltas=0.005<deltap=0.05
A=-20*log10(delta);
if(A>50)
    beta=0.1102*(A-8.7);
elseif(A<21)
    beta=0;
else
    beta=0.5842*(A-21).^0.4+0.07886*(A-21);
end
N1=ceil(1+(A-8)./2.285./(ws-wp));
beta
N1
%% 
% beta=4.09090352143845
% 
% N1=43


load nspeech2;
w = kaiser(N1, beta);
h1 = LPFtrunc(N1);
h2 = h1.*w';
[H,w] = DTFT(h2,512);
figure();
subplot(3,1,1);
plot(w,abs(H));
xlabel('w');
ylabel('|H|');
title('DTFT of filter');

subplot(3,1,2);
plot(w(abs(w)<=1.8),abs(H(abs(w)<=1.8)));
xlabel('w');
ylabel('|H|');
title('passband ripple |w| <= 1.8');

subplot(3,1,3);
plot(w(abs(w)>=2.2),abs(H(abs(w)>=2.2)));
xlabel('w');
ylabel('|H|');
title('stopband ripple |w| >= 2.2');
abs(max(H(abs(w)<=1.8)))%passband ripple:0.0041(减一)
abs(max(H(abs(w)>=2.2)))%stopband ripple:0.0039

%% 
% passband ripple:0.0041
% 
% stopband ripple:0.0039
% 
% 
% 
% *Figure 7.5*: DTFT of a section of noisy speech.


%filtered_sig = conv(h2,nspeech2);
%[F,w2] = DTFT(filtered_sig,512);
filtered_sig_1=filtered_sig(20001:20400);
[F,w2] = DTFT(filtered_sig_1,0);
figure();
plot(w2,20*log10(abs(F)));
title('magnitude of filtered signal in dB');
xlabel('w');
ylabel('magnitude in dB');

% sound(filtered_sig);
% noise and sidelobe decrease. DTFT is smoother.
% audio quality increses
%% 
% 8.4

clear;close all;clc;
load nspeech2.mat;

f=[1.8,2.2];
m=[1,0];
ripple=[0.05,0.005];

[n,fo,mo,w]=firpmord(f,m,ripple,2*pi);
b=firpm(n+3,fo,mo,w);
filterlength=n+3
w1=-pi:0.01:pi;

z=exp(1i*w1);

h_total=b(1);
for k =2:length(b)
h_total=h_total+b(k).*z.^(-(k-1));
end
h_mag=20*log10(abs(h_total));

figure;
sgtitle('DTFT in dB')
subplot(311);plot(w1,h_mag);
subplot(312);plot(w1,h_mag);xlim([-1.8,1.8]);title('passband ripple');
subplot(313);plot(w1,h_mag);xlim([2.2,3.14]);title('stopband ripple');

ripple1= max(abs(h_total(abs(w1)<=1.8)))-1
ripple2= max(abs(h_total(abs(w1)>=2.2)))
result=conv(b,nspeech2);
 sound(result);

figure
[X,w]=DTFT(result(20001:20400),512);
subplot(211);plot(w,abs(X));title('DTFT');
subplot(212);plot(w,20*log10(abs(X)));title('DTFT in dB');
%% 
%