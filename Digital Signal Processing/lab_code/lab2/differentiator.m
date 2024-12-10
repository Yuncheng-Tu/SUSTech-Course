function y=differentiator(x)
% Implement the differentiator system
    
    % Difference equation coefficients for differentiator
    a = [1];
    b = [1 -1];
    
    % Apply the filter to the input signal
    y = filter(b, a, x);
end