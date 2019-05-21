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
opt.grid_scales = [2:6]; 
opt.scales_maps = repmat(2:6,3,1)';
opt.stability_tseries.nb_samps = 100; 
opt.stability_group.nb_samps = 500; 

opt.flag_tseries_network = false; 
files_in.infos = '/home/mpelland/database/blindtvr/models/rest2.csv';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fiels_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/rCalcarineMask.mnc.gz';
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/rCalcarineSeeds.mnc.gz';
opt.folder_out = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Right'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fiels_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/lCalcarineMask.mnc.gz';
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/lCalcarineSeeds.mnc.gz';
opt.folder_out = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Left'; 

%% Run the pipeline %%
[pipeline,opt] = niak_pipeline_stability_rest(files_in,opt);





