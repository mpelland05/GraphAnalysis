fs=filesep;sp=filesep;

SpecNam = {'Low' 'Mid' 'High'};%Name to give to specific groupings

files_in.groups = {'SCxxx'};
files_in.numPermutations = 100000;


for ii = 1:length(SpecNam),
files_in.ScaleStr = SpecNam{ii};
files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
      

%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = strcat('/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/avg_OutputCmpTopo_',SpecNam{ii},'_wAvg.mat');
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = strcat('/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/avg_OutputCmpTopo_',SpecNam{ii},'_wAvg.mat');
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);






%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = strcat('/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/avg_OutputCmpTopo_',SpecNam{ii},'_wAvg.mat');
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = strcat('/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/avg_OutputCmpTopo_',SpecNam{ii},'_wAvg.mat');
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

end