% Define S2 filter function
function y = S2(x)
    N = length(x);
    y = zeros(1, N); % Pre-define the output vector
    for n = 1:N
        if n == 1
            y(n) = x(n); % Initial condition
        else
            y(n) = y(n - 1) / 2 + x(n);
        end
    end
end