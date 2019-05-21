%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setting input/output files %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

root_path = '/home/mpelland/database/blindtvr/fmri/';
%%%%%%%%%
%Grabbing
%%%%%%%%%
opt_g.min_nb_vol = 80; %<-------------------------------------------------------modify to fit the current data!
opt_g.filter.session = {'rest'};
opt_g.exclude_subject = {'LBxxxVDCaMa','LBxxxVDDeBe','LBxxxVDGiCo','LBxxxVDJoBi','LBxxxVDJoBo','LBxxxVDJoGa','LBxxxVDLiJo','LBxxxVDLiVe','LBxxxVDMoLa','LBxxxVDRaDe','LBxxxVDSeBe'};

files_in = niak_grab_fmri_preprocess('/home/mpelland/database/blindtvr/fmri/fmri_preprocess_01_RestOnly_NoSmooth_NoLB',opt_g);



%%%%%%%%%%%%%
% Region growing
%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modify to get mask of occipital regions only.
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_wBASC6_Right.nii';

opt.folder_out = strcat('/home/mpelland/database/Modularity_OC_2016/fmri/','region_growing_RestOnly_CBSCMixed_OccMaskAALBASC_Right/'); 
opt.flag_roi = true; 
opt.region_growing.thre_size = 1000; % The critical size for regions

files_in.infos = '/home/mpelland/database/blindtvr/models/tvr.csv';


%% Run the pipeline
opt.flag_test = false;
[pipeline_rg,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modify to get mask of occipital regions only.
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_wBASC6_Left.nii';

opt.folder_out = strcat('/home/mpelland/database/Modularity_OC_2016/fmri/','region_growing_RestOnly_CBSCMixed_OccMaskAALBASC_Left/'); 
opt.flag_roi = true; 
opt.region_growing.thre_size = 1000; % The critical size for regions

files_in.infos = '/home/mpelland/database/blindtvr/models/tvr.csv';


%% Run the pipeline
opt.flag_test = false;
[pipeline_rg,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modify to get mask of occipital regions only.
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_Right.nii';

opt.folder_out = strcat('/home/mpelland/database/Modularity_OC_2016/fmri/','region_growing_RestOnly_CBSCMixed_OccMaskAAL_Right/'); 
opt.flag_roi = true; 
opt.region_growing.thre_size = 1000; % The critical size for regions

files_in.infos = '/home/mpelland/database/blindtvr/models/tvr.csv';


%% Run the pipeline
opt.flag_test = false;
[pipeline_rg,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Modify to get mask of occipital regions only.
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_Left.nii';

opt.folder_out = strcat('/home/mpelland/database/Modularity_OC_2016/fmri/','region_growing_RestOnly_CBSCMixed_OccMaskAAL_Left/'); 
opt.flag_roi = true; 
opt.region_growing.thre_size = 1000; % The critical size for regions

files_in.infos = '/home/mpelland/database/blindtvr/models/tvr.csv';


%% Run the pipeline
opt.flag_test = false;
[pipeline_rg,opt] = niak_pipeline_stability_rest(files_in,opt);