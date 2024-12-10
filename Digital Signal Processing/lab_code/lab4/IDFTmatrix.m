function B = IDFTmatrix(N)
    j = sqrt(-1); 
    B = zeros(N, N); 
    for k = 1:N
        for n = 1:N
            B(k, n) = exp(j*2*pi*(k-1)*(n-1)/N); % 计算矩阵元素
        end
    end
    B = B / N; % 根据逆DFT的定义，矩阵B的每个元素需要除以N
end