function [pvalues Average STDev] = PairedPermutationTest(group1,group2,nperm,gnames),

groupD = group1-group2;

Average.(gnames{1}) = mean(groupD,2); 

STDev.(gnames{1}) = std(groupD,0,2); 

Diff = Average.(gnames{1});
Pos = Diff.*(Diff > 0);
Neg = Diff.*(Diff < 0);

[tt nPart] = size(groupD);

Count = zeros(tt,1);

for pp = 1:nperm,
    Order = rand(1,nPart); Order = (round(Order).*2)-1; Order = repmat(Order,tt,1);%Create random permutations between pairs, basically, crate random 1's and -1's to multiply with groupD
    
    tDiff = mean(groupD.*Order,2);
    
    tPos = tDiff.*(Diff > 0).*(tDiff > 0);
    tNeg = tDiff.*(Diff < 0).*(tDiff < 0);
      
    Count = Count + ((tPos - Pos) > 0);
    Count = Count + ((tNeg - Neg) < 0);
end

pvalues = Count./nperm;

pvalues(find(pvalues == 0)) = 1/nperm;
end