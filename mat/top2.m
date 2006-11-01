
% top m-file 
clear all;
clc;
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
cpu1 = cputime;
popSz = 8;
elite = 2;
genomlngt = 8;
nParents = 2*(popSz-elite);
max_gen = 200;
fit_limit = 510; % According to fitness evaluation function 
factor = 4;
mut_prob = 75; % According to mut_res from VHDL design
mut_res = 8;
cross_method = 2; % Uniform crossover
mut_method = 2; % Uniform mutation

%%[seed0,seed1,seed2,seed3] = seeds_generator(); % Produce new random seeds
%load seeds                                      % Load  saved random seeds
%% Initializations
fit_limit_reached = 0;
max_gen_reached = 0;
current_gen = 0;
index = 1;
genes=cell(1,max_gen); %zeros(popSz,genomlngt+1);
parents=cell(1,max_gen);
offspring=cell(1,max_gen);
offsprings=cell(1,max_gen);
fit_sum=cell(1,max_gen);
if mut_method == 2 
    mutation_rng = cell(1,max_gen);
end
%% RNG : Creation of popSz genes (ram1) randomly -- Insert various seeds 
LFSR_reg = ones(1,genomlngt);
load_var = 1; 
run = 1;

for i=1:popSz+1
    [temp_genes(i,1:genomlngt)] = rng(load_var,run,seed0,genomlngt,LFSR_reg);
    LFSR_reg = temp_genes(i,1:genomlngt);
    load_var = 0; 
end 
init_genes(1:popSz,1:genomlngt) = temp_genes(1:popSz,1:genomlngt);

%% Fitness evaluation of first generation
[fit_sum{index},max_fit,elite_indexs,best_fit,genes{1}] = initial_fit_evaluation(init_genes);
current_gen = 1;
figure,
while fit_limit_reached == 0 && max_gen_reached == 0 
    
%% RNG : Creation of scale matrix for selection (factor random bits =>
%% converted to dec) Insert various seeds
LFSR_reg = ones(1,factor);
load_var = 1; 
run = 1;

for i=1:nParents+1
    [temp_scale(i,:)] = rng(load_var,run,seed1{index},factor,LFSR_reg);
    LFSR_reg = temp_scale(i,:);
    load_var = 0;     
end
if current_gen == 1 
    scale = bin2dec(num2str(temp_scale(2:nParents+1,:))); % Array of decs
else 
    scale = bin2dec(num2str(temp_scale(1:nParents,:))); % Array of decs
end
%% Selection on current generation (parents array contains the selected parents from genes-ram1)
[parents{index}] = selection(genes{index}, scale, fit_sum{index});

%% RNG : Creation of random crosspoints/mutpoint -- Insert various seeds
LFSR_reg = ones(1,2*log2(genomlngt));
load_var = 1; 
run = 1;

for i=1:nParents/2 + 1
    [temp_cros_mut_points(i,:)] = rng(load_var,run,seed2{index},2*log2(genomlngt),LFSR_reg);
    LFSR_reg = temp_cros_mut_points(i,:);
    temp_cross_points(i,1) = bin2dec(num2str(temp_cros_mut_points(i,1:log2(genomlngt))));
    temp_cross_points(i,2) = bin2dec(num2str(temp_cros_mut_points(i,log2(genomlngt)+1:2*log2(genomlngt))));
    temp_mut_point(i) = bin2dec(num2str(temp_cros_mut_points(i,log2(genomlngt)+1:2*log2(genomlngt))));
    load_var = 0;
end
cross_points = temp_cross_points(2:nParents/2 + 1, :);
mut_point = temp_mut_point(2:nParents/2 + 1);

%% RNG : Creation of random masks -- Insert various seeds
if mut_method ~= 2

LFSR_reg = ones(1,genomlngt+mut_res);
load_var = 1; 
run = 1;

for i=1:2*(popSz-elite)+1 % Acoording to VHDL rng 
    [temp_masks(i,:)] = rng(load_var,run,seed3{index},genomlngt + mut_res,LFSR_reg);
    LFSR_reg = temp_masks(i,:);         
    load_var = 0;

    temp_cross_mask(i,:) = temp_masks(i,1:genomlngt);
    temp_mut_mask(i,:) = temp_masks(i,:);
end
k=1;
for i=1:(popSz-elite)
    mut_rng(i,1:genomlngt) = temp_mut_mask(2*k,1:genomlngt);
    mut_rng(i,genomlngt+1) = bin2dec(num2str(temp_mut_mask(2*k,genomlngt+1:genomlngt+mut_res)));
    cross_mask(i,:) = temp_cross_mask(2*k,1:genomlngt);
    k=k+1;
end
k=0;

else 
    LFSR_reg = ones(1,genomlngt+mut_res);
    load_var = 1; 
    run = 1;
    
    for i=1:(nParents/2)*(genomlngt+2) + 1 % According to VHDL rng [+1 is for seed]
        [temp_masks(i,:)] = rng(load_var,run,seed3{index},genomlngt + mut_res,LFSR_reg);
        LFSR_reg = temp_masks(i,:);         
        load_var = 0;
    end  
    
    ind=1;
    ind2=1;
    for j=1:genomlngt+2:(nParents/2 - 1)*(genomlngt+2) + 1 
            cross_mask(ind,:) = temp_masks(j+1,1:genomlngt);
            ind=ind+1;
            for k=1:genomlngt
                mut_mask(ind2,:) = temp_masks(j+k+1,:);
                ind2=ind2+1;
            end
    end

    for i=1:(popSz-elite)*genomlngt
        mut_rng(i,1:genomlngt) = mut_mask(i,1:genomlngt);
        mut_rng(i,genomlngt+1) = bin2dec(num2str(mut_mask(i,genomlngt+1:genomlngt+mut_res)));
    end
    mutation_rng{index}=mut_rng;
end
%% Crossover performed on parents
[offspring{index}] = crossover(parents{index}, cross_points, cross_mask, cross_method);

%% Mutation performed on parents - Change cell mutation_rng if mut_method/=2
[offsprings{index}] = mutation(offspring{index}, mut_point, mutation_rng{index}, mut_method);

%% Fitness evaluation of new generation - offsprings
[fit_sum{index+1},max_fit,elite_offs,best_fit,genes{index+1}] = fit_evaluation(offsprings{index},elite_indexs,best_fit,genes{index});
plot(current_gen, max_fit, 'pr');
hold on;
for i= 2:elite
color = {'.k' '+c' 'og' '*b' 'xm' 'sg'};
plot(current_gen, best_fit(i), color{i});
end
hold on;
axis([0 current_gen fit_limit*9/10 fit_limit]);
title ('Best fitnesses and max fitness vs Number of generations');
xlabel('Number of generations'); ylabel('Fitness');
h = legend('max fitness','other',4);
set(h,'Interpreter','none', 'Box', 'off');

%% Ανανέωση των elite offsprings
elite_indexs = elite_offs;

%% Observer
[fit_limit_reached, max_gen_reached] = observer(max_fit, current_gen);
current_gen = current_gen + 1;
index = index + 1;
end

 cpu2 = cputime;
 total = cpu2-cpu1;