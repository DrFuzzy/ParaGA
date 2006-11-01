function [fit_sum,max_fit,elite_offs,best_fit,genes] = fit_evaluation(offsprings,elite_indexs,best_fit,genes)


global genomlngt
global elite
global popSz

temp_best_fit = zeros(1,elite);
fit = zeros(1,popSz);
fit_sum = 0;
addr = 0;
elite_offs = zeros(1,elite);
temp_elite_indexs = zeros(1,elite);
temp_elite_indexs=elite_indexs;
for i=1:(popSz-elite)
    fit(i) = 2*bin2dec(num2str(offsprings(i,1:genomlngt)));
    %fit(i) = sin(bin2dec(num2str(offsprings(i,1:genomlngt)))*pi/180)+ 3;
    %fit(i) = -bin2dec(num2str(offsprings(i,1:genomlngt))).^3 + 2*bin2dec(num2str(offsprings(i,1:genomlngt))) + 16580865;
%     x=offsprings(i,1:genomlngt/2);
%     y=offsprings(i,(genomlngt/2) + 1:genomlngt);
%     x_dec=bin2dec(num2str(x));
%     y_dec=bin2dec(num2str(y));
%     x_dec_trans = (6/256)*x_dec - 3;
%     y_dec_trans = (6/256)*y_dec - 3;
%     fit(i) = peaks(x_dec_trans,y_dec_trans) + 7; % Add 7 so as for fitness to b positive (min peaks ~= 7)
    
    % ----------- Benchmark function: F1 Zhang Zhang max=0.148  -----------------------
%     x=offsprings(i,1:genomlngt);
%     x_dec=(1/(2^genomlngt - 1))*binary2integer(x);
%     fit(i) =abs((1-x_dec)*(x_dec^2)*sin(200*pi*x_dec));
       
    % ----------- Benchmark function: F2 Zhang Zhang max=1.0485 -----------------------
%     x=offsprings(i,1:genomlngt);
%     x_dec=(1/(2^genomlngt - 1))*binary2integer(x);
%     fit(i) =((1 - 2*(sin(3*pi*x_dec))^20 + (sin(20*pi*x_dec))^20)^20)/10^6;
%     
    % ----------- Benchmark function: F3 Griewangk  --------------------------
%     x=offsprings(i,1:genomlngt/2);
%     y=offsprings(i,(genomlngt/2) + 1:genomlngt);
%     x_dec=binary2integer(x);
%     y_dec=binary2integer(y);
%     x_dec_trans = (600/(2^(genomlngt/2) - 1))*x_dec - 300;
%     y_dec_trans = (600/(2^(genomlngt/2) - 1))*y_dec - 300;
%     fit(i) = (x_dec_trans^2+y_dec_trans^2)/4000 - cos(x_dec_trans)*cos(y_dec_trans/sqrt(2))+1;
    
    % ----------- Benchmark function: F4 Easom max=2 but depends on the -----------
    % ----------- bits resolution and the range of the space ----------------------
%     x=offsprings(i,1:genomlngt/2);
%     y=offsprings(i,(genomlngt/2) + 1:genomlngt);
%     x_dec=binary2integer(x);
%     y_dec=binary2integer(y);
%     x_dec_trans = (200/(2^(genomlngt/2) - 1))*x_dec - 100;
%     y_dec_trans = (200/(2^(genomlngt/2) - 1))*y_dec - 100;
%     fit(i) =(cos(x_dec_trans)*cos(y_dec_trans))*exp(-((x_dec_trans-pi)^2+(y_dec_trans-pi)^2))+1;    

    % ----------- Benchmark function: F5 Michalewicz max=1.7997 but depends on the ------
    % ----------- bits resolution and the range of the space ----------------------
%     x=offsprings(i,1:genomlngt/2);
%     y=offsprings(i,(genomlngt/2) + 1:genomlngt);
%     x_dec=binary2integer(x);
%     y_dec=binary2integer(y);
%     x_dec_trans = (pi/(2^(genomlngt/2) - 1))*x_dec;
%     y_dec_trans = (pi/(2^(genomlngt/2) - 1))*y_dec;
%     fit(i) = sin(x_dec_trans)*(sin((x_dec_trans^2)/pi))^20 + sin(y_dec_trans)*(sin((2/pi)*y_dec_trans^2))^20;

    % ----------- Benchmark function: F6 Ragistrin max= 119.84  ----------------
%     x=offsprings(i,1:genomlngt/2);
%     y=offsprings(i,(genomlngt/2) + 1:genomlngt);
%     x_dec=binary2integer(x);
%     y_dec=binary2integer(y);
%     x_dec_trans = (10.24/(2^(genomlngt/2) - 1))*x_dec - 5.12;
%     y_dec_trans = (10.24/(2^(genomlngt/2) - 1))*y_dec - 5.12;
%     fit(i) = 100 - (x_dec_trans^2)- (y_dec_trans^2) +10*cos(2*pi*x_dec_trans) + 10*cos(2*pi*y_dec_trans);

    offsprings(i,genomlngt+1) = fit(i);
    fit_sum = fit_sum + fit(i);
    addr = addr +1;

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