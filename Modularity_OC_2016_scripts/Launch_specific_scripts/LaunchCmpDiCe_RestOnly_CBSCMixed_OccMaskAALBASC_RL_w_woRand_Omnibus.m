fs=filesep;sp=filesep;

files_in.groups = {'CBxxx'};
files_in.numPermutations = 100000;
    
files_in.ScaleStr = 'AllScales';
files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
      
    
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Left/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Right/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Left/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);




%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Right/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Left/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Right/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Left/avg_OutputCmpTopo_wAvg.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));
files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','_wAvg.mat');

CompareDiCePaired(files_in,files_out);