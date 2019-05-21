clear all

root_path = '/home/mpelland/database/blindtvr/fmri/';

%%%%%
%Grab
%%%%%%
opt_g.min_nb_vol = 80; %<-------------------------------------------------------modify to fit the current data!
opt_g.filter.session = {'rest'};
opt_g.exclude_subject = {'LBxxxVDCaMa','LBxxxVDDeBe','LBxxxVDGiCo','LBxxxVDJoBi','LBxxxVDJoBo','LBxxxVDJoGa','LBxxxVDLiJo','LBxxxVDLiVe','LBxxxVDMoLa','LBxxxVDRaDe','LBxxxVDSeBe'};

files_in = niak_grab_fmri_preprocess('/home/mpelland/database/blindtvr/fmri/fmri_preprocess_01_RestOnly_NoSmooth_NoLB',opt_g);

%%%%%%
%Basc
%%%%%%
opt.grid_scales = [3:25]; 
opt.scales_maps = repmat(3:25,3,1)';
opt.stability_tseries.nb_samps = 100; 
opt.stability_group.nb_samps = 500; 

opt.flag_tseries_network = false; 
files_in.infos = '/home/mpelland/database/blindtvr/models/rest2.csv';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskBASC6only_Right/rois/brain_rois.mnc.gz';
opt.folder_out = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskBASC6only_Left/rois/brain_rois.mnc.gz';
opt.folder_out = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);



%%%%%%%%%%%%%%%%%%%%With random atoms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Right.mnc';
opt.folder_out = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_rand_OccBASC6_Left.mnc';
opt.folder_out = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);





