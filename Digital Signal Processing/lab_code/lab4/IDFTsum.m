function x = IDFTsum(X)
    N = length(X);        
    j = sqrt(-1);          
    x = zeros(1, N);        

    
    for n = 0:N-1
        for k = 0:N-1
            x(n+1) = x(n+1) + X(k+1) * exp(j * 2 * pi * k * n / N);
        end
        x(n+1) = x(n+1) / N;  
    end

    x = abs(x);  % 消除由于舍入误差可能产生的虚部
end
