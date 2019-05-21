%%%%%%Left
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/stability_ind';
files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/ModValue.mat';

brick_CalculateModularity(files_in,files_out);


%%%%%%Right
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/stability_ind';
files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/ModValue.mat';

brick_CalculateModularity(files_in,files_out);
