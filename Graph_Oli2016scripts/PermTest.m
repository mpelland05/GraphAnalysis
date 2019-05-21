function pval = PermTest(group1,group2,nperm),
%102 x 14

oDiff = mean(group1,2) - mean(group2,2);

groupG = [group1 group2];

Pos = find(oDiff > 0);
Neg = find(oDiff < 0);

[tt nPart1] = size(group1);
[tt nPart2] = size(group2);

nPart = nPart1 + nPart2;

Count = zeros(tt,1);

for pp = 1:nperm,
    Order = randperm(nPart);
    tgroup1 = groupG(:,Order(1:nPart1));
    tgroup2 = groupG(:,Order(nPart1+1:end));
    
    tDiff = mean(tgroup1,2) - mean(tgroup2,2);
    
    if ~isempty(Pos),
        tPos = tDiff(Pos) >= oDiff(Pos);
        Count(Pos) = Count(Pos) + tPos;
    end
    if ~isempty(Neg),
        tNeg = tDiff(Neg) <= oDiff(Neg);
        Count(Neg) = Count(Neg) + tNeg;
    end
end

pval = (Count+1)./(nperm+1);

end