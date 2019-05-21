%aThis script will take group stability results and create group stability
%maps from them. 
fs = filesep;

mfiles_in.path = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/';
mfiles_in.groups = {'CBxxx' 'SCxxx'};
scales = 3:6;
files_in.atoms = '/home/mpelland/database/Modularity_OC_2016/mask/CalcarineStuff/rCalcarineSeeds.mnc.gz';

for gg = 1:length(mfiles_in.groups),
   for ss = 1:size(scales,2),
       
       if size(scales,1) == 1,
            files_in.stability = strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs,'stability_group_',mfiles_in.groups{gg},'_',num2str(scales(ss)),'.mat');
            files_in.hierarchy = files_in.stability;
            
            opt.scales_maps = repmat(scales(ss),1,3);
            opt.folder_out =  strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs,'Scale_',num2str(scales(ss)),fs);
            mkdir( strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs) , strcat('Scale_',num2str(scales(ss))) );
       else
           files_in.stability = strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs,'stability_group_',mfiles_in.groups{gg},'_',num2str(3,scales(ss)),'.mat');
           files_in.hierarchy = files_in.stability;
            
           opt.scales_maps = [repmat(scales(3,ss),1,2) scales(2,ss)];
           opt.folder_out =  strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs,'Scale_',num2str(3,scales(ss)),fs);
           mkdir( strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs) , strcat('Scale_',num2str(3,scales(ss))) );
       end
       
       
       files_out.partition_consensus{1} = strcat(opt.folder_out,'Consensus.mnc.gz');
       files_out.partition_core{1} = strcat(opt.folder_out,'Core.mnc.gz');
       files_out.partition_adjusted{1} = strcat(opt.folder_out,'Adjusted.mnc.gz');
       files_out.partition_threshold{1} = strcat(opt.folder_out,'Threshold.mnc.gz');
       files_out.stability_maps{1} = strcat(opt.folder_out,'Stab_Maps.mnc.gz');
       files_out.stability_maps_all{1} = strcat(opt.folder_out,'Stab_Maps_All.mnc.gz');
       
       niak_brick_stability_maps(files_in,files_out,opt);
   end
end

niak_brick_mnc2nii(mfiles_in.path,mfiles_in.path);