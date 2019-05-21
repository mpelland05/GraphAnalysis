%files_in.scales = 100;
files_in.groups = {'CBxxx'};
gPath = '/home/mpelland/database/blindModularity/Results/';%gPath = '/home/mpelland/database/blindModularity/Results/RestOnly_CBSCMixed_OccMask/';
files_in.path = strcat(gPath,'avg_NoSmooth202_fromGraph_L_wAvg.mat');

fname = 'Perm_avg_NoSmooth202_L';

fs=filesep;
sp=filesep;
files_in.numPermutations = 100000;
    
   
    files_in.ScaleStr = 'AllScales';
    files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    
    CompareDiCePaired(files_in,files_out);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all


%files_in.scales = 100;
files_in.groups = {'CBxxx'};
gPath = '/home/mpelland/database/blindModularity/Results/';%gPath = '/home/mpelland/database/blindModularity/Results/RestOnly_CBSCMixed_OccMask/';
files_in.path = strcat(gPath,'avg_NoSmooth202_fromGraph_R_wAvg.mat');

fname = 'Perm_avg_NoSmooth202_R';

fs=filesep;
sp=filesep;
files_in.numPermutations = 100000;
   
    files_in.ScaleStr = 'AllScales';
    files_in.contrast_name = strcat('CBvsSC_',files_in.ScaleStr);
      
    files_out = strcat(gPath,'Permutated',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    
    CompareDiCePaired(files_in,files_out);
