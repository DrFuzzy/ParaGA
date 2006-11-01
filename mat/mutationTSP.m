function [offsprings] = mutationTSP(offspring, mut_point, mut_rng)

% mut_point : array nParents/2 x 2 (integers)
% mut_rng   : array nParents/2 x 1 (integers)



global nParents
global genomlngt
global mut_prob
global num_towns
offsprings = zeros(nParents/2, genomlngt);

for i=1:nParents/2
    
    % Mutation method in TSP is a swap of two towns
        if mut_rng(i) <= mut_prob
            if mut_point(i,1)==num_towns-1 
                mut_point(i,1)=num_towns-2;
            end
            if mut_point(i,2)==num_towns-1
                mut_point(i,2)=num_towns-2;
            end
            point1=num_towns-mut_point(i,1)-1;
            point2=num_towns-mut_point(i,2)-1;
            offsprings(i,:)=offspring(i,:);
            temp=offsprings(i,(point1-1)*log2(num_towns)+1:point1*log2(num_towns));
            offsprings(i,(point1-1)*log2(num_towns)+1:point1*log2(num_towns))=offsprings(i,(point2-1)*log2(num_towns)+1:point2*log2(num_towns));
            offsprings(i,(point2-1)*log2(num_towns)+1:point2*log2(num_towns))=temp;
        else
            offsprings(i,:)=offspring(i,:);
        end

end
