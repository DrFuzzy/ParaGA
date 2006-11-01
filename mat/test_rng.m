clear all
clc

LFSR_reg = ones(1,4);
load = 1; 
run = 1;

seed = [1 1 0 1]

for i=1:20
    [genes(i,1:4)] = rng(load,run,seed,4,LFSR_reg);
    LFSR_reg = genes(i,1:4);
    int_genes(i) = bin2dec(num2str(genes(i,1:4)));
    load = 0; 
end 
