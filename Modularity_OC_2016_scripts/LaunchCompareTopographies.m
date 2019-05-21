files_in.mask = '/home/mpelland/database/blindModularity/mask/ValTest.nii';    %Use 15, 10 or 7 networks for the mask if using the
                                                                                                            %original parcellation based on CB, LB, SC, rest and task. 
files_in.path='/home/mpelland/database/blindtvr/fmri/basc_01/stability_ind';
files_in.pType = 'consensus';
files_in.filter = {'task','LBxxx'};
files_in.groups = {'CBxxx','SCxxx'};
files_in.contrast = {[1 2]};
files_in.scales = 100;

files_out = '/home/mpelland/database/blindModularity/Results/ValTest.mat';

CompareTopographies(files_in,files_out);