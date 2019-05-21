mfiles_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/';
mfiles_in.groups = {'CBxxx','SCxxx'};

mfiles_in.info{1} = '/home/mpelland/database/blindModularity/models/CB_BascModel.csv'; 
mfiles_in.info{2} = '/home/mpelland/database/blindModularity/models/SC_BascModel.csv'; 

opt.rand_seed = 1;
%files_in.atoms = '/home/mpelland/database/blindModularity/fmri/region_growing_RestOnly_CBSCMixed/rois/brain_rois.mnc.gz';


scales = repmat(3:25,3,1);


for ss = 1:size(scales,2),
    if size(scales,1) == 1,
        opt.nb_classes = scales(ss);
        opt.nb_classes_final = scales(ss);
        opt.nb_classes_ind = scales(ss);
    else
        opt.nb_classes = scales(2,ss);
        opt.nb_classes_final = scales(3,ss);
        opt.nb_classes_ind = scales(1,ss);
    end
    
    IndStab2GroupStab;
end
