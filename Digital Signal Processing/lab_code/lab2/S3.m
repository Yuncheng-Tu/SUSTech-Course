%y[n]=x[n]-1/2x[n-1]
function y = S3(x)  
    % Initialize the length and initial value of y
    len = length(x);
    y = zeros(size(x));
    y(1) = x(1);
    
    % Compute the difference equation for y
    for n = 2:len
         y(n)=x(n)-(1/2)*x(n-1);
    end
end