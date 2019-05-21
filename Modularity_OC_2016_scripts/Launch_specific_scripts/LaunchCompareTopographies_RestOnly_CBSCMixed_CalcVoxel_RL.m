%aThis script will launch compare topographies for the occipital AAL regions and occAAL*BASC06 occipital mask 
%in half the instances, atoms are from the random atom algorithm, the others are grown from Sighted and 
%early blind individuals..

%Variables for all analyses
files_in.scales = 2:6;
files_in.groups = {'CBxxx','SCxxx'};
files_in.contrast = {[1 2]};
files_in.filter = {'NoFilt'};
files_in.pType = 'consensus';


%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fiels_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/rCalcarineMask.mnc.gz';
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/rCalcarineSeeds.mnc.gz';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fiels_in.mask = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/lCalcarineMask.mnc.gz';
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/lCalcarineSeeds.mnc.gz';
files_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/stability_ind'; 

files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/OutputCmpTopo.mat';

mdir = strfind(files_out, filesep); lmdir = length(mdir);
mkdir( files_out(1:mdir(lmdir-1)-1) , files_out(mdir(lmdir-1)+1:mdir(lmdir)-1) );%makes output folder

CompareTopographies(files_in,files_out);

