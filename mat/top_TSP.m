
% top m-file 
close all;
clear all;
clc;
tic
global popSz 
global elite
global genomlngt
global nParents
global factor
global mut_prob
global max_gen
global mut_res
global num_towns
%% Generics - Constants
cpu1 = cputime;
popSz = 16;  % Change the load file too if you dont want to produce a new random initial generation
elite = 2;
num_towns = 8;
genomlngt = (num_towns-1)*log2(num_towns);
nParents = 2*(popSz-elite);
max_gen = 200;
factor = 4;
mut_prob = 100; % According to mut_res from VHDL design
mut_res = 8;

distance_map = [1 1
                1 2
                2 4
                3 5
                2 0
                3 3
                4 1
                5 3
                3 6
                4 7
                6 7
                7 6 
                5 5
                5 4
                6 2
                7 1];
[seed0,seed1,seed2,seed3] = seeds_generatorTSP(); % Produce new random --
%                                                    seeds 
%load seedsTSP;

%% Initializations
fit_limit_reached = 0;
max_gen_reached = 0;
current_gen = 0;
index = 1;
fin=0;
pool=[1 2 3 4 5 6 7];
genes=cell(1,max_gen); %zeros(popSz,genomlngt+1);
parents=cell(1,max_gen);
offspring=cell(1,max_gen);
offsprings=cell(1,max_gen);
fit_sum=cell(1,max_gen);
mutation_rng = cell(1,max_gen);
scale = cell(1,max_gen);
cross_points = cell(1,max_gen);
mut_point = cell(1,max_gen);
max_fit = cell(1,max_gen);
best_fit = cell(1,max_gen);
delete('D:\Designs\GA_eval\sim\ip_vec_ga_tsp.vec');
delete('D:\Designs\GA_eval\sim\op_vec_ga_tsp_tsp.vec');
LFSR_reg_1 = ones(1,factor);
LFSR_reg_2 = ones(1,2*log2(num_towns));
LFSR_reg_3 = ones(1,mut_res);
%% RNG : Creation of popSz genes (ram1) randomly -- Insert various seeds 
load init_genes16; % 8 genes 
% LFSR_reg = ones(1,log2(num_towns)*(num_towns-1));
% load_var = 1; 
% run = 1;
% 
% for i=1:popSz
%     [temp_init_genes(i,:)] = rng(load_var,run,seed0,log2(num_towns)*(num_towns-1),LFSR_reg);
%     LFSR_reg = temp_init_genes(i,:);
%     load_var = 0;    
%     ind=1;
%     for k=1:log2(num_towns):log2(num_towns)*(num_towns-1)
%         initial_genes(i,ind) = bin2dec(num2str(temp_init_genes(i,k:k+log2(num_towns)-1)));
%         ind=ind+1;
%     end
%     initial_genes(i,find(initial_genes(i,:)==0))= ceil(7.*rand(1,1)); % No zeros
%     l=1;
%     m=1;
%     no_change=0;
%     for k=1:num_towns-1
%         if isempty(find(initial_genes(i,:)==pool(k)))==1 
%             missing_towns(l)=k;
%             l=l+1;
%         elseif size(find(initial_genes(i,:)==pool(k)),2)>1
%             repeat_towns(m)=k;
%             indices_rep_towns{m}=find(initial_genes(i,:)==pool(k));
%             m=m+1;
%         elseif size(find(initial_genes(i,:)==pool(k)),2)==1
%             no_change=no_change+1;
%         end
%     end
%     if no_change~=num_towns-1
%         w=1;
%         for n=1:size(indices_rep_towns,2)
%             initial_genes(i,indices_rep_towns{n}(1:size(indices_rep_towns{n},2)-1))=missing_towns(w:w+size(indices_rep_towns{n},2)-2);
%             w=w+size(indices_rep_towns{n},2)-1;
%         end
%         init_genes_dec(i,:)=initial_genes(i,:);
%     else
%         init_genes_dec(i,:)=initial_genes(i,:);
%     end
%     
% % Binary transformation of integer genes
% 
%     ind2=1;
%     for j=1:num_towns-1
%         temp{j}=dec2bin(init_genes_dec(i,j),log2(num_towns));
%     end
%     for j=1:num_towns-1
%         for k=1:log2(num_towns)
%             init_genes(i,ind2)=str2num(temp{j}(k));
%             ind2=ind2+1;
%         end
%     end
%     clear missing_towns;
%     clear repeat_towns;
%     clear indices_rep_towns;
% end

%% Fitness evaluation of first generation

[fit_sum{index},max_fit{index},elite_indexs,best_fit{index},genes{1}] = initial_fit_evaluation_TSP(distance_map,init_genes);
current_gen = 1;
%% Αρχή γενετικού αλγορίθμου

% figure(1),
while fit_limit_reached == 0 && max_gen_reached == 0 
    
%% Δημιουργία των input test vectors
inputtestvectors(1)= bin2dec(num2str(seed1{index})); 
inputtestvectors(2)= bin2dec(num2str(seed2{index})); 
inputtestvectors(3)= bin2dec(num2str(seed3{index})); 
inputtestvectors(4)= 1;
dlmwrite('D:\Designs\GA_eval\sim\ip_vec_ga_tsp.vec', inputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append')

best_fit_prev=best_fit{index}(1);
%% RNG : Creation of scale matrix for selection (factor random bits =>
%% converted to dec) Insert various seeds

%LFSR_reg = ones(1,factor);
load_var = 1; 
run = 1;
if isempty(find(seed1{index})) == 1 && current_gen ~= 1 
    LFSR_reg_1 = temp_scale(nParents,:);
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
load_var = 1; 
run = 1;
k=1;
l=1;
for i=1:nParents/2+1
    [temp_cros_points(i,:)] = rng(load_var,run,seed2{index},2*log2(num_towns),LFSR_reg_2);
    LFSR_reg_2 = temp_cros_points(i,:);
    load_var = 0;
    if i~=1
        cross_points{index}(i-1) = bin2dec(num2str(temp_cros_points(i,1:log2(num_towns))));
        mut_point{index}(i-1,1) = bin2dec(num2str(temp_cros_points(i,1:log2(num_towns))));
        mut_point{index}(i-1,2) = bin2dec(num2str(temp_cros_points(i,log2(num_towns)+1:2*log2(num_towns))));
    end
end

%% RNG : Creation of random mutation probability -- No need of masks for TSP 
load_var = 1; 
run = 1;

for i=1:(popSz-elite)+1 % Acoording to VHDL rng 
    [temp_masks(i,:)] = rng(load_var,run,seed3{index},mut_res,LFSR_reg_3);
    LFSR_reg_3 = temp_masks(i,:);         
    load_var = 0;
    if i~=1 
        mutation_rng{index}(i-1) = bin2dec(num2str(temp_masks(i,:)));
    end
end

%% Crossover performed on parents
[offspring{index}] = crossoverTSP(parents{index}, cross_points{index}, distance_map);

%% Mutation performed on parents - Change cell mutation_rng if mut_method/=2
[offsprings{index}] = mutationTSP(offspring{index}, mut_point{index}, mutation_rng{index});

%% Fitness evaluation of new generation - offsprings
[fit_sum{index+1},max_fit{index+1},elite_offs,best_fit{index+1},genes{index+1}] = fit_evaluation_TSP(distance_map,offsprings{index},elite_indexs,best_fit{index},genes{index});

%% Ανανέωση των elite offsprings
elite_indexs = elite_offs;

%% Δημιουργία των output test vectors
outputtestvectors(1)=elite_offs(1);
outputtestvectors(2)=elite_offs(2);
outputtestvectors(3)=max_fit{index+1};
% outputtestvectors(4)=binary2integer(genes{current_gen}(elite_offs(1),:));
dlmwrite('D:\Designs\GA_eval\sim\op_vec_ga_tsp.vec', outputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append')

%% Observer
if current_gen == max_gen 
    max_gen_reached=1;
    inputtestvectors(1)= 0; 
    inputtestvectors(2)= 0; 
    inputtestvectors(3)= 0; 
    inputtestvectors(4)= 0;
    dlmwrite('D:\Designs\GA_eval\sim\ip_vec_ga_tsp.vec', inputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append');
end
if best_fit_prev==best_fit{index+1}(1)
    fin = fin+1;
else
    fin=0;
end
if fin>=2000 
    fit_limit_reached=1;
    inputtestvectors(1)= 0; 
    inputtestvectors(2)= 0; 
    inputtestvectors(3)= 0; 
    inputtestvectors(4)= 0;
    dlmwrite('D:\Designs\GA_eval\sim\ip_vec_ga_tsp.vec', inputtestvectors, 'delimiter', '\t', 'precision', '%.0f','-append');

end

current_gen = current_gen + 1;
index = index + 1;
end
cpu2 = cputime;
total = cpu2-cpu1;
 
%% Plot Map
figure(1) 
x=1:5:max_gen+1;
y=cell2mat(max_fit);
plot(x, y(x), 'pr', 'MarkerSize',10);
hold on;
for i= 2:elite
color = {'.k' '+c' 'og' '*b' 'xm' 'sg'};
y2=cell2mat(best_fit);
plot(x, y2(2*x), color{i-1});
end

% set axis
axis([0 max_gen+1 0 max_fit{max_gen+1}])
title ('Best fitnesses and max fitness vs Number of generations');
xlabel('Number of generations'); ylabel('Fitness');
h = legend('max fitness','other',4);
set(h,'Interpreter','none', 'Box', 'off');
hold off;

figure(2)

plot(distance_map(:,1), distance_map(:,2), 'ob');
hold on;
axis([0 8 0 8])
best_route=genes{current_gen}(elite_offs(1),:);
ind=1;
for k=1:log2(num_towns):log2(num_towns)*(num_towns-1)
    route(ind) = bin2dec(num2str(best_route(k:k+log2(num_towns)-1)));
    ind=ind+1;
end
x(1)=distance_map(1,1);
y(1)=distance_map(1,2);
x(size(route,2)+2)=distance_map(1,1);
y(size(route,2)+2)=distance_map(1,2);
x(2:size(route,2)+1)=distance_map(route+1,1);
y(2:size(route,2)+1)=distance_map(route+1,2);

plot(x(1:size(route,2)+1),y(1:size(route,2)+1),'g',x(size(route,2)+1:size(route,2)+2),y(size(route,2)+1:size(route,2)+2),'r','Linewidth',3);
%% Execution Time Calculation
toc
exec_time = toc;
