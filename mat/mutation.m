function [offsprings] = mutation(offspring, mut_point, mut_rng, mut_method)

% mutpoints : array nParents/2 x 1 (integers)
% mut_rng   : array 1xgenomlngt+1 
% mut_method  : integer 0 up to 2


global nParents
global genomlngt
global mut_prob

if nargin < 4
    mut_method = 0;
end
offsprings = zeros(nParents/2, genomlngt);

for i=1:nParents/2
    
    if mut_method == 0  % One point mutation
        if mut_rng(i,genomlngt+1) <= mut_prob 
            point=genomlngt-mut_point(i);
            offsprings(i,:)=offspring(i,:);
            offsprings(i,point)=1-offspring(i,point);
        else
            offsprings(i,:)=offspring(i,:);
        end
    
    elseif mut_method == 1 % XOR/Masked mutation
        if mut_rng(i,genomlngt+1) <= mut_prob 
            offsprings(i,:)=xor(offspring(i,:),mut_rng(i,1:genomlngt)) ;
        else
            offsprings(i,:)=offspring(i,:);
        end    
    
    elseif mut_method == 2 % Uniform mutation
        
        for j=1:genomlngt
            if mut_rng((i-1)*genomlngt+j,genomlngt+1) < mut_prob 
                offsprings(i,genomlngt+1-j)=1-offspring(i,genomlngt+1-j);
            else
                offsprings(i,genomlngt+1-j)=offspring(i,genomlngt+1-j);
            end    
        end 
    
    end
   
end
