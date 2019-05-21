function [tt pp] = mTtest(a1,a2,types,tails),
%types: string can be: 'paired' or ind

[x1 y1 z1] = size(a1);
[x2 y2 z2] = size(a2);

tt = zeros(x1,1);

if strcmp(types,'ind'),
    avg1 = mean(a1,2);
    avg2 = mean(a2,2);
    
    std1 = std(a1,1,2);
    std2 = std(a2,1,2);
    
    diffe = avg1-avg2;
    sd = ((std1.*(y1-1))+(std2.*(y2-1)))/(y1+y2-2);
    
    tt = diffe./(sd./((y1+y2-2)^(.5)));
    
    tt(find(isnan(tt))) = 0;
    
    df = y1 + y2 - 2;
end

pp = p4ttest(tt,df,tails);

end