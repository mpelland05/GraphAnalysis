BasePath = '/home/mpelland/database/blindtvr/';

%%%%%%%%%%%%%%%%%
%% Grabbing BASC
%%%%%%%%%%%%%%%%
files_in.networks.atoms = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth_NoLB_wholeRight/rois/brain_rois.mnc.gz'; % <--------------------------------------------------------------------------modify according to desired value

%%%%%%%%%%%%%%%%%%%%%%%
%% Grabbing preprocess
%%%%%%%%%%%%%%%%%%%%%%%
opt_g.exclude_subject = {'LBxxxVDCaMa' 'LBxxxVDDeBe' 'LBxxxVDGiCo' 'LBxxxVDJoBi' 'LBxxxVDJoBo' 'LBxxxVDJoGa' 'LBxxxVDLiJo' 'LBxxxVDLiVe' 'LBxxxVDMoLa' 'LBxxxVDRaDe' 'LBxxxVDSeBe'};

opt_g.min_nb_vol = 80;     
opt_g.min_xcorr_func = 0.5; 
opt_g.min_xcorr_anat = 0.5; 
opt_g.type_files = 'glm_connectome';
files_in.fmri = niak_grab_fmri_preprocess(strcat(BasePath,'fmri/fmri_preprocess_01_wBeMe'),opt_g).fmri;

%remove unwanted  participants
unwan = {'SCxxxVDSC'};
for ii = 1:length(unwan),
    files_in.fmri = rmfield(files_in.fmri,unwan{ii});
end

%%%%%%%%%%%%%%%%
%Load group model
%%%%%%%%%%%%%%%%
files_in.model.group = strcat(BasePath,'models/CBSC_model_group.csv');

%%%%%%%%%%%%%%%%%%%
%Load subject model
%%%%%%%%%%%%%%%%%%
data.group      = {'CBxxx','SCxxx'};
data.subs_CB    = {'VDAlCh','VDAnBe','VDBeMe','VDDiCe','VDFrCo','VDLL','VDMaLa','VDMaDu','VDMoBe','VDNaTe','VDSePo','VDSoSa','VDYP','VDYvLa'}; % n = 14                                     

data.subs_SC    = {'VDCJ','VDChJa','VDClDe','VDGeAl','VDJM','VDJeRe','VDJoFr','VDKaFo','VDLALH','VDMaSa','VDNiLe','VDNiMi','VDOL','VDPG','VDSG','VDTJ'}; % n = 17

ll = 1; %incrementation variable.
for n1 = 1:length(data.subs_CB)
    data.subs_names{ll} = strcat(data.group{1},data.subs_CB{n1});
    ll = ll +1;
end
for n1 = 1:length(data.subs_SC)
    data.subs_names{ll} = strcat(data.group{2},data.subs_SC{n1});
    ll = ll +1;
end
clear ll;
for mm = 1:length(data.subs_names),
    individual.(data.subs_names{mm}).inter_run = strcat(BasePath,'models/',data.subs_names{mm},'.csv');
end

files_in.model.individual = individual;

%%%%%%%%%%%%
%% Options 
%%%%%%%%%%%%
opt.folder_out = '/home/mpelland/database/blindPrepGraph/Covariance_Based/Connectomes/WholeRight/'; % Where to store the results
opt.fdr = 0.1; 
%opt.type_fdr = 'group+family';
opt.fwe = 0.05; 
opt.nb_samps = 1000;
opt.nb_batch = 10;
opt.flag_rand = false;

