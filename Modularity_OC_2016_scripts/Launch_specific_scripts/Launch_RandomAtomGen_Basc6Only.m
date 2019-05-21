%This script will launch random atom generation for the modularity study. 
%This is the second script for it! Woo!.


%Right short version
files_in.nAtm = 100;
files_in.mask = 'CBSC_Rest_Scale6_Occ_Right.nii';
files_in.part = 'roi_aal_3mm.nii';
files_out = 'Atoms_rand_OccBASC6_Right.nii';

RandomAtomGen(files_in,files_out);

%Left short version
files_in.nAtm = 100;
files_in.mask = 'CBSC_Rest_Scale6_Occ_Left.nii';
files_in.part = 'roi_aal_3mm.nii';
files_out = 'Atoms_rand_OccBASC6_Left.nii';

%RandomAtomGen(files_in,files_out);

