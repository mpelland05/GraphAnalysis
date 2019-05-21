%This script will launch compare topographies for the occipital AAL regions and occAAL*BASC06 occipital mask 
%in half the instances, atoms are from the random atom algorithm, the others are grown from Sighted and 
%early blind individuals

%Variables for all analyses
files_in.scales = 3:25;
files_in.groups = {'CBxxx','SCxxx'};
files_in.contrast = {[1 2]};
files_in.filter = {'NoFilt'};
files_in.pType = 'consensus';


%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_wBASC6_Right.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskAALBASC_Right/rois/brain_rois.mnc.gz';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_wBASC6_Left.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskAALBASC_Left/rois/brain_rois.mnc.gz';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Left/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Left/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_Right.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskAAL_Right/rois/brain_rois.mnc.gz';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskAAL_Right/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Right/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_Left.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskAAL_Left/rois/brain_rois.mnc.gz';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_OccMaskAAL_Left/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Left/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);



%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_wBASC6_Right.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_AAL_Occ_wBASC6_Right.mnc';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Right/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Right/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_wBASC6_Left.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_AAL_Occ_wBASC6_Left.mnc';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Left/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Left/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_Right.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_rand_OccMaskAALetBASC_RL/Atoms_AAL_Occ_Right.mnc.mnc';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Right/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Right/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/Occipital/niiAALBrodmann/Mask_AAL_Occ_Left.nii';   
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/fmri/region_growing_RestOnly_CBSCMixed_OccMaskAAL_Left/rois/Atoms_AAL_Occ_Left.mnc';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Left/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Left/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);