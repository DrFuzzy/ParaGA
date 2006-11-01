function [seed0,seed1,seed2,seed3] = seeds_generatorTSP()

global genomlngt
global max_gen
global factor
global mut_res
global num_towns

seed0 = rand(1,log2(num_towns)*(num_towns-1));
seed0(find(seed0<=0.5))=0;
seed0(find(seed0>0.5))=1;

for i=1:max_gen

    seed1{i} = rand(1,factor);
    seed1{i}(find(seed1{i}<=0.5))=0;
    seed1{i}(find(seed1{i}>0.5))=1;

    seed2{i} = rand(1,2*log2(num_towns));
    seed2{i}(find(seed2{i}<=0.5))=0;
    seed2{i}(find(seed2{i}>0.5))=1;

    seed3{i} = rand(1,mut_res);
    seed3{i}(find(seed3{i}<=0.5)) = 0;
    seed3{i}(find(seed3{i}>0.5)) = 1;

end

save('seedsTSP');