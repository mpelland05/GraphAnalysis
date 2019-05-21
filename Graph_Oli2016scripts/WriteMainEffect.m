function WriteMainEffect(files_in),
%files_in
%       .BaseP  string, base path to the file to be loaded (without the
%                       name)
%       .tname  string, name of test (or file).. well both.
%       .p1     cell of string, path to matrix for first group, contains
%               first and second fields that follow tname
%       .p2     cell of string, same as above but for second group
%       .ext    string, name of filed into which the matrix is found
%       .Seeds  vector, list of seeds that will undergo the ttest measure
%               Also, if one sets it to :   ':'
%               then all seeds will be analyzed
%       .tails  int, 1 or 2, number of tails to calculate the p-value
%       .test   string, 'ttest' or 'permutation'
%       .nperm  int, number of permutations
%Modified 14 march 2015, to incluse permutation
BaseP = files_in.BaseP;
otname = files_in.tname;
p1 = files_in.p1;
p2 = files_in.p2;
ext = files_in.ext;
Seeds= files_in.Seeds;
tails = files_in.tails;
nperm = files_in.nperm;


aa = load(strcat(BaseP,otname,'.mat'));

if strcmp(otname(numel(otname)), '0' ), 
    tname = otname(1:end-4);
else
    tname = otname;
end

fn = orderfields( aa.(tname).(p1{1}).(p1{2}).(ext) );
fnn = fieldnames(fn);
loc = find(cellfun('length',fnn) == 5);

if ~isempty(loc),
    tve = 1:length(fnn); tve(loc) = []; ve = [loc tve];
    
    fn = orderfields( fn , ve ); fn = fieldnames(fn);
else
    fn = orderfields( fn ); fn = fieldnames(fn); %Find the names of the thresholds
end

[xx yy] = size(aa.(tname).(p1{1}).(p1{2}).(ext).(fn{1}).mat);%find size of output

if ischar(Seeds),
   Seeds = 1:xx; 
end

Results.tvalue.(ext) = zeros(1,length(Seeds));
Results.pvalue.(ext) = zeros(1,length(Seeds));

%a1 = zeros(xx,yy,length(fn));
%a2 = zeros(xx,yy,length(fn));

for ii = 1:length(fn)
    a1(:,:,ii) = aa.(tname).(p1{1}).(p1{2}).(ext).(fn{ii}).mat;
    a2(:,:,ii) = aa.(tname).(p2{1}).(p2{2}).(ext).(fn{ii}).mat;
end

ma1 = mean(a1,3);
ma2 = mean(a2,3);

[tt pp] = mTtest(ma1,ma2,'ind',tails);
Results.tvalue.(ext)(:) = tt(Seeds);
Results.pvalue.(ext)(:) = pp(Seeds);
if strcmp(files_in.test, 'permutation'),
    pp = PermTest(ma1,ma2,nperm);
    Results.pvalue.(ext)(:) = pp(Seeds);
end

Results.legend.Seeds = Seeds;
Results.legend.Thresh = fn;
save(strcat(BaseP,otname,'_Main_Effect_tvalue.mat'),'Results');

zer = zeros(1,length(Seeds));
Res = cat(1,Results.tvalue.(ext),zer,Results.pvalue.(ext));

xlswrite(strcat(BaseP,otname,'_Main_Effect_Results.xls'),Res);

end