% Mutation method in TSP is a swap of two towns
clc;
clear all;
num_towns=8;
i=1;
mut_rng(1) = 70;
mut_prob  = 75;
mut_point(1,1) = 3;
mut_point(1,2) = 7;
offspring(1,:) = [0 0 1 0 1 0 1 1 1 1 0 0 0 1 1 1 0 1 1 1 0 ];
% [1 2 7 4 3 5 6]
% [3,2,7,4,1,5,6;]
        if mut_rng(i) < mut_prob 
            point1=num_towns-mut_point(i,1);
            point2=num_towns-mut_point(i,2);
            offsprings(i,:)=offspring(i,:);
            temp=offsprings(i,(point1-1)*log2(num_towns)+1:point1*log2(num_towns));
            offsprings(i,(point1-1)*log2(num_towns)+1:point1*log2(num_towns))=offsprings(i,(point2-1)*log2(num_towns)+1:point2*log2(num_towns));
            offsprings(i,(point2-1)*log2(num_towns)+1:point2*log2(num_towns))=temp;
        else
            offsprings(i,:)=offspring(i,:);
        end