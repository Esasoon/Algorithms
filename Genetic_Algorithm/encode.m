function [x_DNA] = encode(x,WayOfCoding)
% 编码，包含二进制、格雷码变异方式
x_bin = my_dec2bin(x,4);
if WayOfCoding == 1 % 二进制编码
    x_DNA = x_bin;
elseif WayOfCoding == 0 % 格雷码编码
    x_r1 = my_dec2bin(bitshift(x, -1),4); % 右移一位在编码为二进制
    % 计算格雷码 
    x_DNA = xor(x_bin,x_r1);
end
end


