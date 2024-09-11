function [bin] = my_dec2bin(dec,nums)
% 十进制转二进制
% bin：输出的二进制数据，dec：输入的十进制数据，nums：编码位数
    cols = size(dec, 2);
    bin = zeros(nums, cols); % 初始化二进制矩阵
    
    for i = 1:cols
        % 计算二进制表示
        num = dec(1, i);
        for j = nums:-1:1
            bin(i, j) = mod(num, 2); % 计算余数并填充到矩阵
            num = floor(num / 2);   % 整数除以2
        end
    end
end

