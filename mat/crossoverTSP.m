function [offspring] = crossoverTSP(parents, cross_points, distance_map)

% crosspoints : array 1x1 (integer)
% Distance_map : array of town coordinates
% crossmethod  : integer 0 up to 2


global nParents
global genomlngt
global num_towns

offs = 0; % offspring counter
child_ind = 1;
ind=1;
offspring = zeros(nParents/2, genomlngt);
children = zeros(nParents, num_towns-1);
temp_offspring =zeros(nParents/2, num_towns-1);
pool = [1 2 3 4 5 6 7];
for i=1:2:nParents-1
    offs = offs+1;
    
    % Implement one point crossover for TSP
    
        temp_1=parents(i,1:genomlngt);   % Parent A
        temp_2=parents(i+1,1:genomlngt); % Parent B
        
        for k=1:log2(num_towns):log2(num_towns)*(num_towns-1)
            temp1(ind)=bin2dec(num2str(temp_1(k:k+log2(num_towns)-1)));
            temp2(ind)=bin2dec(num2str(temp_2(k:k+log2(num_towns)-1)));
            ind=ind+1;
        end
        ind=1;
        
        point=num_towns-cross_points(offs);
        for j=1:point-1
            children(child_ind,j)=temp1(j);   % Child A takes left part from Parent A
            children(child_ind+1,j)=temp2(j); % Child B takes left part from Parent B
        end
        setA=0;
        setB=0;
        clear free_indices1;
        clear free_indices2;
        for j=point:num_towns-1
            if isempty(find(children(child_ind,:)==temp2(j)))==1 % Child A takes left part from Parent B
                children(child_ind,j)=temp2(j); % Αν δε συμπίπτει με κάποιο από τα ήδη υπάρχοντα τότε θέσε
            else % Αλλιώς άστο κενό και κράτα το index της κενής θέσης
                setA=setA+1;
                free_indices1(setA)=j;
            end
            
            % Creation of Child B 
            
            if isempty(find(children(child_ind+1,:)==temp1(j)))==1 % Child B takes left part from Parent A
                children(child_ind+1,j)=temp1(j); % Αν δε συμπίπτει με κάποιο από τα ήδη υπάρχοντα τότε θέσε
            else % Αλλιώς άστο κενό και κράτα το index της κενής θέσης
                setB=setB+1;
                free_indices2(setB)=j;
            end
        end 
        
        if setA~=0 
            existing_townsA=children(child_ind,find(children(child_ind,:)~=0));
            pool(existing_townsA)=0;
            non_existing_townsA=find(pool~=0);
            children(child_ind,free_indices1)=non_existing_townsA;
        end
        pool = [1 2 3 4 5 6 7];
        if setB~=0 
            existing_townsB=children(child_ind+1,find(children(child_ind+1,:)~=0));
            pool(existing_townsB)=0;
            non_existing_townsB=find(pool~=0);
            children(child_ind+1,free_indices2)=non_existing_townsB;
        end
        pool = [1 2 3 4 5 6 7];    
        % Decide which child is fitter
%         temp_fitA =0;
%         temp_fitB =0;
%         for l=1:num_towns-2
%             tempA = sqrt(power(distance_map(children(child_ind,l)+1,1)-distance_map(children(child_ind,l+1)+1,1),2)...
%                        + power(distance_map(children(child_ind,l)+1,2)-distance_map(children(child_ind,l+1)+1,2),2));
%             temp_fitA = temp_fitA + tempA;
%                     
%             tempB = sqrt(power(distance_map(children(child_ind+1,l)+1,1)-distance_map(children(child_ind+1,l+1)+1,1),2)...
%                        + power(distance_map(children(child_ind+1,l)+1,2)-distance_map(children(child_ind+1,l+1)+1,2),2));
%             temp_fitB = temp_fitB + tempB;
%         end
    
%         fitnessA = temp_fitA + sqrt(power(distance_map(children(child_ind,1),1)- distance_map(1,1),2)...
%                                   + power(distance_map(children(child_ind,1),2)- distance_map(1,2),2))...
%                              + sqrt(power(distance_map(children(child_ind,num_towns-1),1)-distance_map(1,1),2)...
%                                   + power(distance_map(children(child_ind,num_towns-1),2)-distance_map(1,2),2));
%         fitA = 1/fitnessA;
%             
%         fitnessB = temp_fitB + sqrt(power(distance_map(children(child_ind+1,1),1)- distance_map(1,1),2)...
%                                   + power(distance_map(children(child_ind+1,1),2)- distance_map(1,2),2))...
%                              + sqrt(power(distance_map(children(child_ind+1,num_towns-1),1)-distance_map(1,1),2)...
%                                   + power(distance_map(children(child_ind+1,num_towns-1),2)-distance_map(1,2),2));
%         fitB = 1/fitnessB;
%         
%         if fitA >= fitB
            temp_offspring(offs,:)=children(child_ind,:);
%         else 
%             temp_offspring(offs,:)=children(child_ind+1,:);            
%         end
        ind2=1;
        for j=1:num_towns-1
            temp{j}=dec2bin(temp_offspring(offs,j),log2(num_towns));
        end
        for j=1:num_towns-1
            for k=1:log2(num_towns)
                offspring(offs,ind2)=str2num(temp{j}(k));
                ind2=ind2+1;
            end
        end
        child_ind = child_ind +2;
end













