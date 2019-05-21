%%%%%%%%%%%%%%%%%%%%
%%IMPORTANT NOTES%%
%%%%%%%%%%%%%%%%%%%%
%There is no need for launcher, so this should be considered a template.
%Please rename the file before modifying it. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setting input/output files %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all

root_path = '/home/mpelland/database/blindtvr/fmri/';
%%%%%%%%%
%Grabbing
%%%%%%%%%
opt_g.min_nb_vol = 80; %<-------------------------------------------------------modify to fit the current data!
files_in = niak_grab_fmri_preprocess([root_path 'fmri_preprocess_01_RestOnly_NoSmooth_NoLB/'],opt_g);

%Removes LBs and set the in data
ff = fieldnames(files_in.data);

co = 0;
for ii = 1:length(ff),
    if isempty(strfind(ff{ii},'LBxxx'))
        co = co + 1;
        files_in.fmri{co} = files_in.data.(ff{ii}).rest.run;
    end
end
      
rmfiled('files_in','data');

opt.flag_test = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Launch right and left stuff
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Left
%Modify to get mask of occipital regions only.
files_in.mask = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth_NoLB_wholeLeft/rois/brain_rois.mnc.gz';

files_out = struct();opt = struct();
files_out.tseries = [];
opt.folder_out = '/home/mpelland/database/blindPrepGraph/Whole_left';

[files_in,files_out,opt] = niak_brick_tseries(files_in,files_out,opt);

%Rights
clear files_out;clear opt;
files_in.mask = '/home/mpelland/database/blindtvr/fmri/region_growing_01_RestOnly_NoSmooth_NoLB_wholeRight/rois/brain_rois.mnc.gz';

files_out = struct();opt = struct();
files_out.tseries = [];
opt.folder_out = '/home/mpelland/database/blindPrepGraph/Whole_Right';

[files_in,files_out,opt] = niak_brick_tseries(files_in,files_out,opt);
