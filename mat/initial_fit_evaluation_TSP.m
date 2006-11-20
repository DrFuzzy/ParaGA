function [fit_sum,max_fit,elite_offs,best_fit,genes] = initial_fit_evaluation_TSP(distance_map,genes)


global genomlngt
global elite
global popSz
global num_towns

best_fit = zeros(1,elite);
fit = zeros(1,popSz);
fit_sum = 0;
temp_fit = 0;
max_fit = best_fit(1);
elite_offs = zeros(1,elite);
elite_indexs = zeros(1,elite);
ind=1;
for i=1:popSz
    
    % Create integer matrix for towns
    for k=1:log2(num_towns):log2(num_towns)*(num_towns-1)
        temp_int_offs(i,ind) = bin2dec(num2str(genes(i,k:k+log2(num_towns)-1)));
        ind=ind+1;
    end
    ind=1;
    
%     for l=1:num_towns-2
%         temp = sqrt(power(distance_map(temp_int_offs(l)+1,1)-distance_map(temp_int_offs(l+1)+1,1),2)...
%                   + power(distance_map(temp_int_offs(l)+1,2)-distance_map(temp_int_offs(l+1)+1,2),2));
%         temp_fit = temp_fit + temp;
%     end
%     
%     fitness(i) = temp_fit + sqrt(power(distance_map(temp_int_offs(i,1)+1,1)- distance_map(1,1),2)...
%                              + power(distance_map(temp_int_offs(i,1)+1,2)- distance_map(1,2),2))...
%                         + sqrt(power(distance_map(temp_int_offs(i,num_towns-1)+1,1)-distance_map(1,1),2)...
%                              + power(distance_map(temp_int_offs(i,num_towns-1)+1,2)-distance_map(1,2),2));
%     fit(i) = 10000/fitness(i);   
    for l=1:num_towns-2
        temp = power(distance_map(temp_int_offs(i,l)+1,1)-distance_map(temp_int_offs(i,l+1)+1,1),2)...
                  + power(distance_map(temp_int_offs(i,l)+1,2)-distance_map(temp_int_offs(i,l+1)+1,2),2);
        temp_fit = temp_fit + temp;
    end
    
    fitness(i) = temp_fit + power(distance_map(temp_int_offs(i,1)+1,1)- distance_map(1,1),2)...
                             + power(distance_map(temp_int_offs(i,1)+1,2)- distance_map(1,2),2)...
                        + power(distance_map(temp_int_offs(i,num_towns-1)+1,1)-distance_map(1,1),2)...
                             + power(distance_map(temp_int_offs(i,num_towns-1)+1,2)-distance_map(1,2),2);
%     fit(i) = floor(100000/fitness(i));   
    fit(i) = 65535 - fitness(i);
    genes(i,genomlngt+1) = fit(i);
    fit_sum = fit_sum + fit(i);
    temp_fit=0;
    for j=1:elite
        
        % We dont care about elite children coz its the initial generation,
        % so we just fill the "ram"
        if (fit(i) > best_fit(j)) && (j ~= elite)
            for k=j:elite-1
                best_fit(elite+j-k) = best_fit(elite+j-k-1);
                elite_indexs(elite+j-k) = elite_indexs(elite+j-k-1);
            end
            % Ανανέωση fitnesses και δεικτών
            best_fit(j) = fit(i);
            elite_indexs(j) = i;
            break;
        elseif (fit(i) > best_fit(j)) && (j == elite)
            % Ανανέωση fitnesses και δεικτών
            best_fit(elite) = fit(i);
            elite_indexs(elite) = i;
            break;
        else 
        end
        
    end
end

elite_offs = elite_indexs;
max_fit = best_fit(1);