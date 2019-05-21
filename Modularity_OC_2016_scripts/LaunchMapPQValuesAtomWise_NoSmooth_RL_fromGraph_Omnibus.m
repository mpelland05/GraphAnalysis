%LauncMapPQValuesAtomWise

files_in.p = 0.025/102; files_in.q = 0.05;
files_in.type = 'BH';

gPath = '/home/mpelland/database/blindModularity/Results/Permutated/Perm_avg_NoSmooth202_L';

fs=filesep;


    
    files_in.scale = 'AllScales'
    files_in.contrast_name = strcat('CBvsSC_',files_in.scale);
          
    files_in.path = strcat(gPath,files_in.scale,'_Paired.mat')
    
    %pvalues
    files_out = strcat(gPath,files_in.scale,'_P_Paired')
    MapPValuesAtomWise(files_in,files_out);
    
    %qvalues
    files_out = strcat(gPath,files_in.scale,'_Q_Paired')
    MapQValuesAtomWise(files_in,files_out);






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


files_in.p = 0.025/111; 



%LauncMapPQValuesAtomWise

gPath = '/home/mpelland/database/blindModularity/Results/Permutated/Perm_avg_NoSmooth202_R';

fs=filesep;

    files_in.scale = 'AllScales'
    files_in.contrast_name = strcat('CBvsSC_',files_in.scale);
          
    files_in.path = strcat(gPath,files_in.scale,'_Paired.mat')
    
    %pvalues
    files_out = strcat(gPath,files_in.scale,'_P_Paired')
    MapPValuesAtomWise(files_in,files_out);
    
    %qvalues
    files_out = strcat(gPath,files_in.scale,'_Q_Paired')
    MapQValuesAtomWise(files_in,files_out);
