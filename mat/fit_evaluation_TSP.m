function [fit_sum,max_fit,elite_offs,best_fit,genes] = fit_evaluation_TSP(distance_map,offsprings,elite_indexs,best_fit,genes)

global genomlngt
global elite
global popSz
global num_towns

temp_best_fit = zeros(1,elite);
fit = zeros(1,popSz);
fit_sum = 0;
addr = 0;
temp_fit=0;
ind=1;
elite_offs = zeros(1,elite);
temp_elite_indexs = zeros(1,elite);
temp_elite_indexs=elite_indexs;

for i=1:(popSz-elite)
    
    for k=1:log2(num_towns):log2(num_towns)*(num_towns-1)
        temp_int_offs(i,ind) = bin2dec(num2str(offsprings(i,k:k+log2(num_towns)-1)));
        ind=ind+1;
    end
    ind=1;
%     for l=1:num_towns-2
%         temp = sqrt(power(distance_map(temp_int_offs(l)+1,1)-distance_map(temp_int_offs(l+1)+1,1),2)...
%                   + power(distance_map(temp_int_offs(l)+1,2)-distance_map(temp_int_offs(l+1)+1,2),2));
%         temp_fit = temp_fit + temp;
%     end
% Fitness calculation according to VHDL
    for l=1:num_towns-2
        temp = power(distance_map(temp_int_offs(i,l)+1,1)-distance_map(temp_int_offs(i,l+1)+1,1),2)...
                  + power(distance_map(temp_int_offs(i,l)+1,2)-distance_map(temp_int_offs(i,l+1)+1,2),2);
        temp_fit = temp_fit + temp;
    end    
    fitness(i) = temp_fit + power(distance_map(temp_int_offs(i,1)+1,1)- distance_map(1,1),2)...
                             + power(distance_map(temp_int_offs(i,1)+1,2)- distance_map(1,2),2)...
                        + power(distance_map(temp_int_offs(i,num_towns-1)+1,1)-distance_map(1,1),2)...
                             + power(distance_map(temp_int_offs(i,num_towns-1)+1,2)-distance_map(1,2),2);
    %fit(i) = floor(100000/fitness(i));   
    fit(i) = 65535 - fitness(i);
    offsprings(i,genomlngt+1) = fit(i);
    fit_sum = fit_sum + fit(i);
    addr = addr +1;
    temp_fit=0;
    for j=1:elite
        
        if (fit(i) > best_fit(j)) && (j ~= elite)
            for k=j:elite-1
                best_fit(elite+j-k) = best_fit(elite+j-k-1);
                elite_indexs(elite+j-k) = elite_indexs(elite+j-k-1);
            end
            % Ανανέωση στο genes (ram1)
            if isempty(find(addr==temp_elite_indexs)) == 1 % Δεν γράφω πάνω στα elite παιδιά
                genes(addr,:) = offsprings(i,:);
            else                                      % Γράφω μετά το elite παιδί
                addr=addr+1;
                while isempty(find(addr==temp_elite_indexs)) == 0 % loop while addr is equal to an elite index
                    addr = addr+1;
                end    
                genes(addr,:) = offsprings(i,:);
            end 
            % Ανανέωση fitnesses και δεικτών
            best_fit(j) = fit(i);
            elite_indexs(j) = addr;
            break;
            
        elseif (fit(i) > best_fit(j)) && (j == elite)

            % Ανανέωση στο genes (ram1)
            if isempty(find(addr==temp_elite_indexs)) == 1 % Δεν γράφω πάνω στα elite παιδιά
                genes(addr,:) = offsprings(i,:);
            else                                      % Γράφω μετά το elite παιδί
                addr=addr+1;
                while isempty(find(addr==temp_elite_indexs)) == 0 % loop while addr is equal to an elite index
                    addr = addr+1;
                end    
                genes(addr,:) = offsprings(i,:);
            end 
            % Ανανέωση fitnesses και δεικτών
            best_fit(elite) = fit(i);
            elite_indexs(elite) = addr;
            break;
            
        else 
            % Ανανέωση στο genes (ram1) - This gene doesn't affect the
            % elite offsprings of the next generation 
            if isempty(find(addr==temp_elite_indexs)) == 1 % Δεν γράφω πάνω στα elite παιδιά
                genes(addr,:) = offsprings(i,:);
            else                                      % Γράφω μετά το elite παιδί
                addr=addr+1;
                while isempty(find(addr==temp_elite_indexs)) == 0 % loop while addr is equal to an elite index
                    addr = addr+1;
                end    
                genes(addr,:) = offsprings(i,:);
            end 
        end
        
    end
end
% Elite children fitnesses must be added too
fit_sum = fit_sum + sum(genes(temp_elite_indexs,genomlngt+1));
elite_offs = elite_indexs;
max_fit = best_fit(1);