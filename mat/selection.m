function [parents] = selection(genes, scale, fit_sum)

% scale : 1xnParents array of decs
% fit_sum : positive integer
% genes : popSz x genomlngt+1 array 
% parents : nParents x genomlngt array 

global genomlngt
global popSz
global nParents
global factor

cumSum = 0;
parents = zeros(nParents,genomlngt);

for i=1:nParents % Creation of "nParents" parents (ram2)
    
    scalFitSum = floor(fit_sum*scale(i)/(2^factor));
    
    for j=1:popSz % Run through genes (ram1)
        cumSum = cumSum + genes(j,genomlngt+1);
        if cumSum > scalFitSum
            parents(i,1:genomlngt) = genes(j,1:genomlngt);
            break;
        else
        end
    end
    cumSum = 0;
    
end