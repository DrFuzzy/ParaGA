function [offspring] = crossover(parents, cross_points, cross_mask, cross_method)

% crosspoints : array 1x2 (integers)
% cross_mask   : array 1xgenomlngt (ones and zeros)
% crossmethod  : integer 0 up to 2


global nParents
global genomlngt

if nargin < 4
    cross_method = 0;
end
offs = 0; % offspring counter
offspring = zeros(nParents/2, genomlngt);

for i=1:2:nParents-1
    offs = offs+1;
    if cross_method == 0 % One point crossover
        temp1=parents(i,1:genomlngt);
        temp2=parents(i+1,1:genomlngt);
        point=genomlngt-cross_points(offs,1); % allazo to +1 Tha exo prob sto apo kato for
        for j=1:point-1
            offspring(offs,j)=temp2(j);
        end
        for j=point:genomlngt
            offspring(offs,j)=temp1(j);
        end
        
    elseif cross_method == 1 % Two point crossover    
        temp1=parents(i,1:genomlngt);
        temp2=parents(i+1,1:genomlngt);
        point1=genomlngt-cross_points(offs,1);
        point2=genomlngt-cross_points(offs,2);
        
        if point1 < point2
            offspring(offs,:)=temp2;     
            for j=point1:point2-1 
                offspring(offs,j)=temp1(j);
            end
        elseif point1 > point2
            offspring(offs,:)=temp2;     
            for j=point2:point1-1 
                offspring(offs,j)=temp1(j);
            end

        elseif point1 == point2 % No crossover
            offspring(offs,:)=temp2;
            offspring(offs,point1) = temp1(point1);
        end
        
    elseif cross_method == 2 % Uniform crossover
        temp1=parents(i,1:genomlngt);
        temp2=parents(i+1,1:genomlngt);
        indexs2=find(cross_mask(offs,:)==1); 
        indexs1=find(cross_mask(offs,:)==0);
        offspring(offs,indexs2)=temp2(indexs2);
        offspring(offs,indexs1)=temp1(indexs1);      
    end
end













