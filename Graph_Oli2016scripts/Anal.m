function writeTTest(tname,p1,p2,ext,Seeds),
%files_in
%       .BaseP  string, base path to the file to be loaded (without the
%                       name)
%       .tname  string, name of test (or file).. well both.
%       .p1     cell of string, path to matrix for first group, contains
%               first and second fields that follow tname
%       .p2     cell of string, same as above but for second group
%       .ext    string, name of filed into which the matrix is found
%       .Seeds  vector, list of seeds that will undergo the ttest measure

aa = load(strcat(BaseP,tname,'.mat'));

fn = fieldnames(aa.(tname).(p1{1}).(p1{2})); %Find the names of the thresholds

[xx yy] = size(aa.(tname).(p1{1}).(p1{2}).(fn{1}).(ext));%find size of output

tt.(ext) = zeros(length(fn),length(Seeds));

for ii = 1:length(fn)
    a1 = aa.(tname).(p1{1}).(p1{2}).(fn{ii}).(ext);
    a2 = aa.(tname).(p2{1}).(p2{2}).(fn{ii}).(ext);
    temp = mTtest(a1,a2,'ind');
    tt.mat(ii,:) = temp(Seeds);
end
tt.legend.Seeds = Seeds;
tt.legend.Thresh = fn;
save(strcat(BaseP,tname,'_tvalue.mat'),'tt');
xlswrite(strcat(BaseP,tname,'_tvalue.xls'),tt.mat);

end