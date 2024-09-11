function [x] = my_bin2dec(mat)
% 二进制转十进制
% x：十进制输出，mat：二进制输入
    rows = size(mat, 1);
    cols = size(mat, 2);
    x = zeros(rows,1);
    for ir = 1:rows
        for ic = 1:cols
            if mat(ir,ic)
                x(ir,1) = x(ir,1) + 2^(cols-ic);
            end
        end  
    end

end

