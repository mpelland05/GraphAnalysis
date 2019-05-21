clear all

root_path = '/home/mpelland/database/blindModularity/fmri/';

%%%%%
%Grab
%%%%%%
opt_g.type_files = 'roi';
opt_g.exclude_subject = {'LBxxxVDCaMa' 'LBxxxVDDeBe' 'LBxxxVDGiCo' 'LBxxxVDJoBi' 'LBxxxVDJoBo' 'LBxxxVDJoGa' 'LBxxxVDLiJo' 'LBxxxVDLiVe' 'LBxxxVDMoLa' 'LBxxxVDRaDe' 'LBxxxVDSeBe'};
files_in = niak_grab_fmri_preprocess('/home/mpelland/database/blindtvr/fmri/fmri_preprocess_01_RestOnly_NoSmooth_NoLB/', opt_g);
files_in.data = files_in.fmri;

%%%%%%%%%%%%%%%%%%%%% Left %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%
%Basc
%%%%%%
files_in.mask = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth/Lrois/Mask.nii';
files_in.atoms = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth/Lrois/voxel_rois.nii';

opt.folder_out = [root_path 'basc_RestOnly_CBSCMixed_OccMask_VoxelBased_Left/']; 

opt.grid_scales = 3:5; 
%opt.scales_maps = [5 4 4; 11 9 10; 18 17 16; 45 36 34; 70 70 68; 90 108 84];
opt.stability_tseries.nb_samps = 100; 
opt.stability_group.nb_samps = 500; 

opt.flag_tseries_network = true; 

files_in.infos = '/home/mpelland/database/blindModularity/models/BascModel.csv';

%opt.psom.qsub_options = '-q qwork@ms -l walltime=05:00:00';

%%%%%%%%%%%%%%%%%%%%%%
%% Run the pipeline %%
%%%%%%%%%%%%%%%%%%%%%%
opt.flag_test = false;
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%% Right %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%
%Basc
%%%%%%
files_in.mask = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth/Rrois/Mask.nii';
files_in.atoms = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth/Rrois/voxel_rois.nii';

opt.folder_out = [root_path 'basc_RestOnly_CBSCMixed_OccMask_VoxelBased_Right/']; 

opt.grid_scales = 3:5; 
%opt.scales_maps = [5 4 4; 11 9 10; 18 17 16; 45 36 34; 70 70 68; 90 108 84];
opt.stability_tseries.nb_samps = 100; 
opt.stability_group.nb_samps = 500; 

opt.flag_tseries_network = true; 

files_in.infos = '/home/mpelland/database/blindModularity/models/BascModel.csv';

%opt.psom.qsub_options = '-q qwork@ms -l walltime=05:00:00';

%%%%%%%%%%%%%%%%%%%%%%
%% Run the pipeline %%
%%%%%%%%%%%%%%%%%%%%%%
opt.flag_test = false;
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);