    %Script to make the ttest between various graph theory measures. 
addpath('F:\GraphAnalysis\scripts\');
addpath('F:\GraphAnalysis\scripts\Specific');

SubScales = { 'sci102_scg102_scf102'};%{'sci190_scg190_scf190'};%'sci5_scg4_scf4' 'sci11_scg9_scf10' 
%SubScales = { 'sci18_scg17_scf16' 'sci45_scg36_scf34' 'sci70_scg70_scf68' 'sci90_scg108_scf84'};

for susu = 1:length(SubScales),

files_in.BaseP = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{susu},'\');
files_in.p1 = {'rest' 'CB'};
files_in.p2 = {'rest' 'SC'};
files_in.ext = 'mat';
files_in.Seeds = ':';
files_in.tails = 2;

tname = {'NNet' 'Modularity' 'PropIntra' 'Efficiency_glob'};% 'PropIntra' 'PrevIntra'};%{'NNet' 'Modularity' ;'NNet_130' 'Modularity_130'; 'NNet_170' 'Modularity_170'; 'NNet_200' 'Modularity_200'};

for ll = 1:size(tname,1),
    files_in.tname{1} = tname{ll,1};files_in.tname{2} = tname{ll,2}; files_in.tname{3} = tname{ll,3}; files_in.tname{4} = tname{4};
    Get_Avg_Std(files_in);
end

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all




%Script to make the ttest between various graph theory measures. 
addpath('F:\GraphAnalysis\scripts\');
addpath('F:\GraphAnalysis\scripts\Specific');

SubScales = { 'sci111_scg111_scf111'};%{'sci190_scg190_scf190'};%'sci5_scg4_scf4' 'sci11_scg9_scf10' 
%SubScales = { 'sci18_scg17_scf16' 'sci45_scg36_scf34' 'sci70_scg70_scf68' 'sci90_scg108_scf84'};

for susu = 1:length(SubScales),

files_in.BaseP = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{susu},'\');
files_in.p1 = {'rest' 'CB'};
files_in.p2 = {'rest' 'SC'};
files_in.ext = 'mat';
files_in.Seeds = ':';
files_in.tails = 2;

tname = {'NNet' 'Modularity' 'PropIntra' 'Efficiency_glob'};% 'PropIntra' 'PrevIntra'};%{'NNet' 'Modularity' ;'NNet_130' 'Modularity_130'; 'NNet_170' 'Modularity_170'; 'NNet_200' 'Modularity_200'};

for ll = 1:size(tname,1),
    files_in.tname{1} = tname{ll,1};files_in.tname{2} = tname{ll,2}; files_in.tname{3} = tname{ll,3}; files_in.tname{4} = tname{4};
    Get_Avg_Std(files_in);
end

end
