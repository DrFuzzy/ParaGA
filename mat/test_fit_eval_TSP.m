
% top m-file 
clear all;
clc;

global popSz 
global elite
global genomlngt
global nParents
global num_towns


num_towns = 8;
popSz = 8;
elite = 2;
genomlngt = (num_towns-1)*log2(num_towns) 
nParents = 2*(popSz-elite);
distance_map = [1 1
                1 2
                2 4
                3 5
                2 0.5
                3 3
                4 1
                5 3];

genes=zeros(popSz,genomlngt+1);
%offsprings=zeros(popSz-elite,genomlngt+1);
elite_indexs=zeros(1,elite);
best_fit=zeros(1,elite);

%% Fitness evaluation test
load init_genes
[fit_sum,max_fit,elite_offs,best_fit,genes] = initial_fit_evaluation_TSP(distance_map,genes);
ind=1;

for i=1:popSz
    % Create integer matrix for towns
    for k=1:log2(num_towns):log2(num_towns)*(num_towns-1)
        temp_int_offs(i,ind) = bin2dec(num2str(genes(i,k:k+log2(num_towns)-1)));
        ind=ind+1;
    end
    ind=1;
end
%[fit_sum,max_fit,elite_offs,best_fit,genes] = fit_evaluation_TSP(distance_map,offsprings,elite_indexs,best_fit,genes)




