% Define S1 filter function
function y = S1(x)
    N = length(x);
    y = zeros(1, N); % Pre-define the output vector
    for n = 1:N
        if n == 1
            y(n) = x(n); % Initial condition
        else
            y(n) = x(n) - x(n - 1);
        end
    end
end