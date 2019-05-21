function writeTTest_p(tname,p1,p2),
%ex: writeTTest('Degrees',{'Rest','CB'},{'Rest','SC'})
BaseP = 'F:\Connectivity\GraphTheory\gMaxAnalysis\Partials\';

Seeds = [21    26    40    62    65    80    82    88    96    99];%Seeds to investigate

aa = load(strcat(BaseP,tname,'_partials.mat'));

fn = fieldnames(aa.(tname).(p1{1}).(p1{2})); %Find the names of the thresholds

[xx yy] = size(aa.(tname).(p1{1}).(p1{2}).(fn{1}).mat);%find size of output

tt.mat = zeros(length(fn),length(Seeds));

for ii = 1:length(fn)
    a1 = aa.(tname).(p1{1}).(p1{2}).(fn{ii}).mat;
    a2 = aa.(tname).(p2{1}).(p2{2}).(fn{ii}).mat;
    temp = mTtest(a1,a2,'ind');
    tt.mat(ii,:) = temp(Seeds);
end
tt.legend.Seeds = Seeds;
tt.legend.Thresh = fn;
save(strcat(BaseP,tname,'_tvalue_partials.mat'),'tt');
xlswrite(strcat(BaseP,tname,'_tvalue_partials.xls'),tt.mat);

end