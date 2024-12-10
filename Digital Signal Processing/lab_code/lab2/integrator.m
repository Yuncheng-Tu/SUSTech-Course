function y=integrator(x)
    % Implement the integrator system
    
    % Difference equation coefficients for integrator
    a = [1 -1];
    b = [1];
    
    % Apply the filter to the input signal
    y = filter(b, a, x);
end