function WriteTTest(files_in),
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
tname = files_in.tname;
p1 = files_in.p1;
p2 = files_in.p2;
ext = files_in.ext;
Seeds= files_in.Seeds;
tails = files_in.tails;
nperm = files_in.nperm;


aa = load(strcat(BaseP,tname,'.mat'));

fn = fieldnames( aa.(tname).(p1{1}).(p1{2}).(ext) ); %Find the names of the thresholds

[xx yy] = size(aa.(tname).(p1{1}).(p1{2}).(ext).(fn{1}).mat);%find size of output

if ischar(Seeds),
   Seeds = 1:xx; 
end

Results.tvalue.(ext) = zeros(1,length(Seeds));
Results.pvalue.(ext) = zeros(1,length(Seeds));

for ii = 1:length(fn)
    a1 = aa.(tname).(p1{1}).(p1{2}).(ext).(fn{ii}).mat;
    a2 = aa.(tname).(p2{1}).(p2{2}).(ext).(fn{ii}).mat;

end

[tt pp] = mTtest(a1,a2,'ind',tails);
Results.tvalue.(ext)(ii,:) = tt(Seeds);
Results.pvalue.(ext)(ii,:) = pp(Seeds);


Results.legend.Seeds = Seeds;
Results.legend.Thresh = fn;
save(strcat(BaseP,tname,'_tvalue.mat'),'Results');

zer = zeros(1,length(Seeds));
Res = cat(1,Results.tvalue.(ext),zer,Results.pvalue.(ext));

xlswrite(strcat(BaseP,tname,'_Results.xls'),Res);

end