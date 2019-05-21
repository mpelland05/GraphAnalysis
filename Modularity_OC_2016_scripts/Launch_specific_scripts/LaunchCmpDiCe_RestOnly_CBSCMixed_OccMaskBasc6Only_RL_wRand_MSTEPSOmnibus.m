fs=filesep;sp=filesep;

SpecNam = {'L36' 'M512'};%Name to give to specific groupings

files_in.groups = {'CBxxx'};
files_in.numPermutations = 100000;


for ii = 1:length(SpecNam),
files_in.ScaleStr = SpecNam{ii};
files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
      

%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = strcat('/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/avg_OutputCmpTopo_',SpecNam{ii},'_wAvg.mat');
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = strcat('/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/avg_OutputCmpTopo_',SpecNam{ii},'_wAvg.mat');
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

end
