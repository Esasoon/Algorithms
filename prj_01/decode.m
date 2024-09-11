function [x] = decode(x_DNA,WayOfCoding)
% 解码
rows = size(x_DNA,1);
cols = size(x_DNA,2);

if WayOfCoding==1 % 二进制解码
    x = my_bin2dec(x_DNA);
elseif WayOfCoding==0 % 格雷码解码

    % 转化为二进制码
    x_bin = zeros(rows, cols);
    for i = 1:rows
       x_bin(i,1) = x_DNA(i,1); % 最高位
        % 逐位进行异或运算
        for j = 2:cols
            x_bin(i,j) = xor(x_bin(i,j-1), x_DNA(i,j));
        end 
    end
    x = my_bin2dec(x_bin);

end

end

