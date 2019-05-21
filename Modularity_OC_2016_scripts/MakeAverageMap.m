%This script will take a voxel, check for each participants what its
%network looks like and add them together, allowing to see differences
%between the groups

fs = filesep;

for side = 1,%1:2, %loop over left and right stuff

if side == 1, %left
    files_in = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/stability_ind';
    files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/CompareMaps/';%general name of file
    idx = [88529]%[75321 74803 48721]; %lMT 75321; lTipp 74803; lFFA 48721; ltipp2 115986; lother 88529
    seedname = {'lOther'}%{'lMT' 'lTipp' 'lFFA'};
else
    files_in = '/home/mpelland/database/Modularity_OC_2016/fmri/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/stability_ind';
    files_out = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/CompareMaps/';%general name of file
    idx = [74818]%[78857 54682 102222]; %rMT 78857; rTipp 54682; rother 102222; rtipp2 74818
    seedname = {'rTipp2'}%{'rMT' 'rTipp' 'rother'};
end


mscale{1} = {'sci18_scf18' 'sci19_scf19' 'sci20_scf20' 'sci21_scf21' 'sci22_scf22' 'sci23_scf23' 'sci24_scf24' 'sci25_scf25'};
mscale{2} = {'sci10_scf10' 'sci11_scf11' 'sci12_scf12' 'sci13_scf13' 'sci14_scf14' 'sci15_scf15' 'sci16_scf16' 'sci17_scf17'};
mscale{3} = {'sci3_scf3' 'sci4_scf4' 'sci5_scf5' 'sci6_scf6' 'sci7_scf7' 'sci8_scf8' 'sci9_scf9' 'sci9_scf9'};
mscale{4} = {'sci3_scf3' 'sci4_scf4' 'sci5_scf5' 'sci6_scf6' 'sci7_scf7' 'sci8_scf8' 'sci9_scf9' 'sci9_scf9' ...
	      'sci10_scf10' 'sci11_scf11' 'sci12_scf12' 'sci13_scf13' 'sci14_scf14' 'sci15_scf15' 'sci16_scf16' 'sci17_scf17' ...
		'sci18_scf18' 'sci19_scf19' 'sci20_scf20' 'sci21_scf21' 'sci22_scf22' 'sci23_scf23' 'sci24_scf24' 'sci25_scf25'};

mscalename = {'High' 'Mid' 'Low' 'AllScales'}

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
