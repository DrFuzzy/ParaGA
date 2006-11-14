% top m-file 
clear all;
clc;
tic
global popSz 
global elite
global genomlngt
global nParents
global factor
global mut_prob
global fit_limit
global max_gen
global mut_res

%% Generics - Constants
popSz = 8;
elite = 2;
genomlngt = 8;
nParents = 2*(popSz-elite);
max_gen = 100;
fit_limit = 511; % According to fitness evaluation function 
factor = 4;
mut_prob = 150; % according to mut_res from VHDL design
mut_res = 8;
cross_method =2;
mut_method =2;
%% Produce random seeds
[seed,seed1,seed2,seed3] = seeds_generator();
%load seeds_tsp
%% Initializations
fit_limit_reached = 0;
max_gen_reached = 0;
current_gen = 0;
genes = cell(1,max_gen+1);
parents = cell(1,max_gen);
offspring = cell(1,max_gen);
offsprings = cell(1,max_gen);
fit_sum = cell(1,max_gen);
max_fit = cell(1,max_gen);
best_fit = cell(1,max_gen);
mutation_rng = cell(1,max_gen);
scale = cell(1,max_gen);
cross_points = cell(1,max_gen);
mut_point = cell(1,max_gen);
best_fit = cell(1,max_gen);
index = 1;
LFSR_reg = ones(1,genomlngt);
LFSR_reg_1 = ones(1,factor);
LFSR_reg_2 = ones(1,2*log2(genomlngt));
LFSR_reg_3 = ones(1,genomlngt+mut_res);
delete('D:\Designs\GA_eval\sim\ip_vec_ga.vec');
delete('D:\Designs\GA_eval\sim\op_vec_ga.vec');

%% RNG : Creation of popSz genes (ram1) randomly -- Insert various seeds 
%LFSR_reg = ones(1,genomlngt);
load_var = 1; 
run = 1;

for i=1:popSz
    [genes{index}(i,1:genomlngt)] = rng(load_var,run,seed,genomlngt,LFSR_reg);
    LFSR_reg = genes{index}(i,1:genomlngt);
    load_var = 0; 
end 

%% Fitness evaluation of first generation
[fit_sum{index},max_fit{index},elite_indexs,best_fit{index},genes{index}] = initial_fit_evaluation(genes{index});
current_gen = 1;

while fit_limit_reached == 0 && max_gen_reached == 0 
%% Input test vectors creation
    inputtestvectors(1)= bin2dec(num2str(seed)); 
    inputtestvectors(2)= bin2dec(num2str(seed1{index})); 
    inputtestvectors(3)= bin2dec(num2str(seed2{index})); 
    inputtestvectors(4)= binary2integer(seed3{index}); 
    inputtestvectors(5)= 1;
    inputtestvectors(6)= cross_method;
    inputtestvectors(7)= mut_method;
    dlmwrite('D:\Designs\GA_eval\sim\ip_vec_ga.vec', inputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append')
%% RNG : Creation of scale matrix for selection (factor random bits =>
%% converted to dec) Insert various seeds
% LFSR_reg = ones(1,factor);
load_var = 1; 
run = 1;

if isempty(find(seed1{index})) == 1 && current_gen ~= 1 % Manipulation of zero seed input
    LFSR_reg_1 = temp_scale(nParents,:);
    note = 1;
end

for i=1:nParents+1
    [temp_scale(i,:)] = rng(load_var,run,seed1{index},factor,LFSR_reg_1);
    LFSR_reg_1 = temp_scale(i,:);
    load_var = 0;     
end

if current_gen == 1 
    scale{index} = bin2dec(num2str(temp_scale(2:nParents+1,:))); % Array of decs
else 
    scale{index} = bin2dec(num2str(temp_scale(1:nParents,:))); % Array of decs
end
%% Selection on current generation (parents array contains the selected parents from genes-ram1)
[parents{index}] = selection(genes{index}, scale{index}, fit_sum{index});

%% RNG : Creation of random crosspoints/mutpoint -- Insert various seeds
%LFSR_reg = ones(1,2*log2(genomlngt));
load_var = 1; 
run = 1;

if isempty(find(seed2{index})) == 1 && current_gen ~= 1 % Manipulation of zero seed input
    LFSR_reg_2 = temp_cros_mut_points(nParents/2+1,:);
end

for i=1:nParents/2+1
    [temp_cros_mut_points(i,:)] = rng(load_var,run,seed2{index},2*log2(genomlngt),LFSR_reg_2);
    LFSR_reg_2 = temp_cros_mut_points(i,:);
    cros_mut_points(i,1) = bin2dec(num2str(temp_cros_mut_points(i,1:log2(genomlngt))));
    cros_mut_points(i,2) = bin2dec(num2str(temp_cros_mut_points(i,log2(genomlngt)+1:2*log2(genomlngt))));
    load_var = 0;
    if i~=1 
        cross_points{index}(i-1,:) = cros_mut_points(i,:);
        mut_point{index}(i-1) = cros_mut_points(i,2);
    end
end

%% RNG : Creation of random masks -- Insert various seeds
% LFSR_reg = ones(1,genomlngt+mut_res);
if mut_method ~= 2
    
    load_var = 1; 
    run = 1;
    k=0;
    l=0;                                         

    if isempty(find(seed3{index})) == 1 && current_gen ~= 1 % Manipulation of zero seed input
        LFSR_reg_3 = temp_masks(nParents+1,:);
    end

    for i=1:nParents+1
        [temp_masks(i,:)] = rng(load_var,run,seed3{index},genomlngt + mut_res,LFSR_reg_3);
        LFSR_reg_3 = temp_masks(i,:);         
        load_var = 0;
        if i~=1
            %if isequal(rem(i,2),0)  
                k=k+1;
                cross_mask{index}(k,:) = temp_masks(i,1:genomlngt);
            %else
            %    l=l+1;
                mut_mask{index}(k,:) = temp_masks(i,:);
            %end
        end
    end

    for i=1:(popSz-elite)
        mutation_rng{index}(i,1:genomlngt) = mut_mask{index}(i,1:genomlngt);
        mutation_rng{index}(i,genomlngt+1) = bin2dec(num2str(mut_mask{index}(i,genomlngt+1:genomlngt+mut_res)));
    end

else % mut_method == 2
    load_var = 1; 
    run = 1;                                         
    ind=1;
    ind2=1;
    zero = 0;
    if isempty(find(seed3{index})) == 1 && current_gen ~= 1 
        LFSR_reg_3 = temp_masks((nParents/2)*(genomlngt+2)+1,:);
        zero = 1;
    end
    for i=1:(nParents/2)*(genomlngt+3) + 1 % According to VHDL rng [+1 is for seed]
        [temp_masks(i,:)] = rng(load_var,run,seed3{index},genomlngt + mut_res,LFSR_reg_3);
        LFSR_reg_3 = temp_masks(i,:);         
        load_var = 0;
    end
    for j=1:genomlngt+3:(nParents/2 - 1)*(genomlngt+3) + 1 
        cross_mask{index}(ind,:) = temp_masks(j+1,1:genomlngt);
        ind=ind+1;
        for k=1:genomlngt
            mut_mask{index}(ind2,:) = temp_masks(j+k+1,:);
            ind2=ind2+1;
        end
    end 

    for i=1:(popSz-elite)*genomlngt
        mutation_rng{index}(i,1:genomlngt) = mut_mask{index}(i,1:genomlngt);
        mutation_rng{index}(i,genomlngt+1) = bin2dec(num2str(mut_mask{index}(i,genomlngt+1:genomlngt+mut_res)));
    end
    
end
%% Crossover performed on parents
[offspring{index}] = crossover(parents{index}, cross_points{index}, cross_mask{index}, cross_method);

%% Mutation performed on parents
[offsprings{index}] = mutation(offspring{index}, mut_point{index}, mutation_rng{index}, mut_method);

%% Fitness evaluation of new generation - offsprings
[fit_sum{index+1},max_fit{index+1},elite_offs,best_fit{index+1},genes{index+1}] = fit_evaluation(offsprings{index},elite_indexs,best_fit{index},genes{index});

%% Ανανέωση των elite offsprings
elite_indexs = elite_offs;

%% Output test vectors creation
outputtestvectors(1)=elite_offs(1);
outputtestvectors(2)=elite_offs(2);
outputtestvectors(3)=max_fit{index+1};
% outputtestvectors(4)=binary2integer(genes{current_gen}(elite_offs(1),:));
dlmwrite('D:\Designs\GA_eval\sim\op_vec_ga.vec', outputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append')
%% Observer
[fit_limit_reached, max_gen_reached] = observer(max_fit{index+1}, current_gen);
if max_gen_reached==1 || fit_limit_reached == 1;
    inputtestvectors(1)= 0; 
    inputtestvectors(2)= 0; 
    inputtestvectors(3)= 0; 
    inputtestvectors(4)= 0;
    inputtestvectors(5)= 0;
    inputtestvectors(6)= 0;
    inputtestvectors(7)= 0;
    dlmwrite('D:\Designs\GA_eval\sim\ip_vec_ga.vec', inputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append');
end
index = index + 1;
current_gen = current_gen + 1;
end
%% Execution Time Calculation
toc
calc_time = toc;
