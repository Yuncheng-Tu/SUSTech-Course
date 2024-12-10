

function [X, w] = DTFTsamples(x)
    N = length(x);
    k = 0:N-1;
    w = 2*pi*k/N;
    w(w >= pi) = w(w >= pi) - 2*pi; % Shift the range from [0,2*pi] to [-pi,pi]
    w = fftshift(w); % Reorder frequencies
    X = fftshift(DFTsum(x)); % Reorder DFT samples
end