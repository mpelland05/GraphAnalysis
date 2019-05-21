%%%%%%Left
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/stability_ind/';
files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/ModValue.mat';

brick_CalculateModularity(files_in,files_out);


%%%%%%Right
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/stability_ind/';
files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/ModValue.mat';

brick_CalculateModularity(files_in,files_out);

%rand
%%%%%%Left
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/stability_ind/';
files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/ModValue.mat';

brick_CalculateModularity(files_in,files_out);


%%%%%%Right
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/stability_ind/';
files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/ModValue.mat';

brick_CalculateModularity(files_in,files_out);