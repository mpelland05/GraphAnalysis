function [a1 a2 avg1 avg2 IX1 IX2] = QuickAvgThresh(aa),

testn = fieldnames(aa);

fn = fieldnames(aa.(testn{1}).CB.mat);

for ii = 1:length(fn)
    a1(:,:,ii) = aa.(testn{1}).CB.mat.(fn{ii}).mat;
    a2(:,:,ii) = aa.(testn{1}).SC.mat.(fn{ii}).mat;
end

a1 = mean(a1,3);
a2 = mean(a2,3);

avg1 = mean(a1,2);
avg2 = mean(a2,2);

[B,IX1] = sort(avg1,'descend');  
[B,IX2] = sort(avg2,'descend'); 


end

%aa = Betweenness; [a1 a2 avg1 avg2] = QuickAvgThresh(aa); [rr alp] = corrcoef(avg1,avg2)
%for ii = 2:110,[rr alp]=corrcoef(IX1((end-ii):end),IX2(IX1((end-ii):end)));res(ii) = rr(2,1);pval(ii)=alp(2,1);end

%for jj = 1:10000,
%avg1 = rand(1,111);
%avg2 = rand(1,111);
%[B,IX1] = sort(avg1);  
%[B,IX2] = sort(avg2); 
%for ii = 2:110,[rr alp]=corrcoef(IX1((end-ii):end),IX2(IX1((end-ii):end)));res(ii) = rr(2,1);pval(ii)=alp(2,1);end

%bres(:,jj) = res;
%end
