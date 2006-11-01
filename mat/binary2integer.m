function [integer_matrix] = binary2integer(matrix,step)

[rows,length] = size(matrix);
if nargin<2 
    step = length;
end

ind = 1;

for i=1:rows
    for j=1:step:length-step+1
        indexs = step - find(matrix(i,j:j+step-1));
        base = 2.*ones(1,size(indexs,2));
        integer_matrix(i,ind) = sum(base.^(indexs));
        ind = ind+1;
        clear indexs;
        clear base;
    end
    ind=1;

end 