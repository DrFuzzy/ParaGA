clc


for i=1:8
    ind2=1;
    for j=1:num_towns-1
        temp{j}=dec2bin(a(i,j),log2(num_towns));
    end
    for j=1:num_towns-1
        for k=1:log2(num_towns)
            a_bin(i,ind2)=str2num(temp{j}(k));
            ind2=ind2+1;
        end
    end
end