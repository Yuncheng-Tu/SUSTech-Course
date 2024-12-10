load('No28Round2_ECG.mat');

x=ECGsignal(20001:22048);
fx = fft(x);
%fnoise=[zeros(1, 74), random('norm', 0, 5000, 1, 350)+i*random('norm', 0, 5000, 1, 350), zeros(1, 600)];
fnoise=[zeros(1, 74), 10000*rand(1, 350), zeros(1, 600)];
fnoise=[fliplr(fnoise) fnoise];
%fnoise(fnoise>1000)=fnoise(fnoise>1000)/50;

fy=fx+fnoise;
y=ifft(fy);
figure(1);
hhh = plot((1:length(x))/300, x);
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

figure(2)
hhh=plot((1:length(y))/300, fnoise);
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

figure(3)
hhh=plot((1:length(y))/300, y);
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth',2);
set(axisx, 'FontSize', 24);
axis tight;

figure(4)
hhh=plot((0:length(fx)-1)/(length(fx)-1), abs(fx(1:length(fx))));
axisx=xlabel('Frequency, \omega/\pi');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1.5 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;


figure(5)
hhh=plot((0:length(fy)/2-1)/(length(fy)/2-1), abs(fy(1:length(fy)/2)));
axisx=xlabel('Frequency, \omega/\pi');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1.5 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

figure(6) %Fourier Domain Filtering
T=length(fy)
k1=round(T/2*.55)
k2=round(T/2*.95)
fy_filtered = fy;
fy_filtered(k1:k2)=zeros(1, k2-k1+1);
fy_filtered(T-k2:T-k1)=zeros(1, k2-k1+1);
a=length(fy_filtered)

%hhh=plot((0:length(fy)/2-1)/(length(fy)/2-1), abs(fy_filtered(1:length(fy)/2)));
hhh=plot((0:length(fy)-1)/(length(fy)-1), abs(fy_filtered-fy));
axisx=xlabel('Frequency, \omega/\pi');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1.5 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

figure(7)

y_filtered = ifft(fy_filtered);
hhh = plot((1:length(x))/300, real(y_filtered),(1:length(x))/300, x );
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

figure(8)
error = real(y_filtered) - x;
hhh = plot((1:length(x))/300, error);
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

% Time domain filtering
figure(9);
fh=ones(size(fy));
fh(k1:k2)=zeros(1, k2-k1+1);
fh(T-k2:T-k1)=zeros(1, k2-k1+1);
h=ifft([1 1 fh]);
y_timedomainfiltered = conv(h,x);
y_timedomainfiltered = y_timedomainfiltered(1:2048);
ratio =sum(abs(real(x)))./sum(abs(real( y_timedomainfiltered)))
hhh = plot((1:length(y_timedomainfiltered))/300, ratio.*real((y_timedomainfiltered)),(1:length(x))/300, x );
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;

figure(10)
error = ratio.*real(y_timedomainfiltered) - x;
hhh = plot((1:length(x))/300, error);
axisx=xlabel('Time, s');
set(gca, 'FontSize', 24, 'PlotBoxAspectRatio', [3 1 1]);
set(hhh, 'LineWidth', 2);
set(axisx, 'FontSize', 24);
axis tight;


