function X=DTFT(x,n0,dw)
%n0 time index of 1st element of x
%dw spacing between the samples of the Matlab vector
N = length(x); % Length of the input signal
    w = -pi:dw:pi; % Vector of frequency values

    X = zeros(size(w)); % Initialize the DTFT result

    for k = 1:length(w)
        omega = w(k);
        X(k) = 0; % Initialize the summation for this frequency component

        for n = 1:N
            X(k) = X(k) + x(n) * exp(-1i * omega * (n + n0 - 1));
        end
        %X(k)=sum( x.*exp(-1i * omega * (n + n0 - 1)) );
    end
end
%X(k)=sum(x.*exp(-j*w(k).*n));

