%LauncMapPQValuesAtomWise.

files_in.q = 0.025;%Use of 0.05 since we do both hemispheres (equivalent to 0.1)
files_in.type = 'BY'; %because some tests might be negatively correlated


%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/104; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/Permutated/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;




files_in.scale = 'AllScales'
files_in.contrast_name = strcat('CBvsSC_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/101; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/Permutated/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;



files_in.scale = 'AllScales'
files_in.contrast_name = strcat('CBvsSC_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);






%%%%%%%%%%%%
%%% rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/103; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/Permutated/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;



files_in.scale = 'AllScales'
files_in.contrast_name = strcat('CBvsSC_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/101; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/Permutated/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;




files_in.scale = 'AllScales'
files_in.contrast_name = strcat('CBvsSC_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);

