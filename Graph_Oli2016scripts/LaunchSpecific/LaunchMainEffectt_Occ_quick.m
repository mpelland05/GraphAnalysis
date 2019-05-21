%Script to make the ttest between various graph theory measures. 
addpath('F:\GraphAnalysis\scripts\');
addpath('F:\GraphAnalysis\scripts\Specific');

%SubScales = {'sci1_scg1_scf1'};%'sci5_scg4_scf4'
SubScales = { 'sci202_scg202_scf202'}; %{'sci190_scg190_scf190'};%{ 'sci202_scg202_scf202'};%{ 'sci11_scg9_scf10' 'sci18_scg17_scf16' 'sci45_scg36_scf34' 'sci70_scg70_scf68' 'sci90_scg108_scf84' 'sci190_scg190_scf190'};

for susu = 1:length(SubScales),

files_in.BaseP = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\MST\',SubScales{susu},'\');
files_in.p1 = {'rest' 'CB'};
files_in.p2 = {'rest' 'SC'};
files_in.ext = 'mat';
files_in.Seeds = ':';
files_in.tails = 2;
files_in.test = 'permutation';
files_in.nperm = 100000;

tname = {'Efficiency'};%{'SizeComp' 'NumComp'};%{'NNet' 'Efficiency_glob' 'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'Modularity'};%{'NNet_130' 'NNet_170' 'NNet_200' 'Modularity_130' 'Modularity_170' 'Modularity_200'}%{'NNet' 'Modularity'};%{'NNet' 'Efficiency_glob' 'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Modularity'};%

for ll = 1:length(tname),
    files_in.tname = tname{ll};
    WriteTTest(files_in);  
    WriteMainEffect(files_in);
end

end