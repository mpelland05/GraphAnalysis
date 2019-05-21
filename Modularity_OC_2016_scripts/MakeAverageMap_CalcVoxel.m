%This script will take a voxel, check for each participants what its
%network looks like and add them together, allowing to see differences
%between the groups

fs = filesep;

for side = 1:2, %loop over left and right stuff

if side == 1, %left
    files_in = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/stability_ind';
    files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/CompareMaps/';%general name of file
    idx = [85669 74914];  
    seedname = {'lone' 'ltwo'};
else
    files_in = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/stability_ind';
    files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/CompareMaps/';%general name of file
    idx = [82502 74919];
    seedname = {'rone' 'rtwo'};
end


mscale{1} = {'sci4_scf4'};
mscalename = {'Four'};

groups = {'CBxxx' 'SCxxx'}; 

%%%%%
%loop seeds and mscales
%%%%% 
for se = 1:length(idx),
for mm = 1:length(mscale),

%%%%%%%%%
% Pierre's way of getting rid of folders or files
%%%%%%%%%
dir_files = dir(files_in);
mask_dir = [dir_files.isdir];
list_all = {dir_files.name};
mask_dot = ismember(list_all,{'.','..'});
dir_files = dir_files(~mask_dot);
mask_dir = mask_dir(~mask_dot);
list_all = list_all(~mask_dot);
list_files = list_all(~mask_dir);
list_dir = list_all(mask_dir);


aa = ones(1,length(groups));
counter = zeros(1,length(groups));

for gg = 1:length(groups),
gg
    for ss = 1:length(mscale{mm}),
        scale = mscale{mm}{ss};
	 
        for pp = 1:length(list_dir),
            fname = strcat(files_in,fs,list_dir{pp},fs,scale,fs,'brain_partition_consensus_ind_',list_dir{pp},'_',scale,'.mnc.gz');
    
            if ~isempty(strfind(fname,groups{gg})),
                counter(gg) = counter(gg) + 1;
            
                [hdr,tvol] = niak_read_vol(fname);
            
                if aa(gg) == 1,
                    svol = zeros(size(tvol));
                    aa(gg) = 0;
                end
            
                svol = svol + (tvol == tvol(idx(se)));
            
            end
        end
    end
    avol{gg} = svol./counter(gg);
    hdr.file_name = strcat(files_out,seedname{se},'_',mscalename{mm},'_',groups{gg},'.mnc.gz');
    niak_write_vol(hdr,avol{gg});
end

%Save difference volume between groups
hdr.file_name = strcat(files_out,seedname{se},'_',mscalename{mm},'_Diff_Groups.mnc.gz');
dvol = avol{1}-avol{2};
niak_write_vol(hdr,dvol);

end
end
end
