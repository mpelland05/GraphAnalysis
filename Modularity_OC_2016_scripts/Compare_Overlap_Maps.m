function Compare_Overlap_Maps(files_in,files_out),

%This script will take files with the same name but different group and make a statistical comparison between them
%before saving the result as a volume in the same folder
%
%files_in
%	.path		string, full path to directory containing the files
%	.groups		cell of strings, each string allowing to differentiate groups
%	.n_size		matrix, same size as groups, should be the number of participants in 
%			each group
%	.threshold	double a zscore over which results are deemed significant
%
%files_out 	        string, what name to give to append to outputfiles
%
%ex: 
%files_in.groups = {'CBxx' 'SCxx'};
%files_in.n_size = [14 17];
%files_in.threshold = 1.644 %equivalent to 0.1 two tailed
%files_in.out_name = 
fs = filesep;

%%%%%%%%%
% Pierre's way of getting rid of folders or files
%%%%%%%%%
dir_files = dir(files_in.path);
mask_dir = [dir_files.isdir];
list_all = {dir_files.name};
mask_dot = ismember(list_all,{'.','..'});
dir_files = dir_files(~mask_dot);
mask_dir = mask_dir(~mask_dot);
list_all = list_all(~mask_dot);
list_files = list_all(~mask_dir);
list_dir = list_all(mask_dir);


locG1 = find(~cellfun('isempty',strfind(list_files,files_in.groups{1})) == 1);

for mm = 1:length(locG1),
    namvol1 = strcat(files_in.path,fs,list_files{locG1(mm)});
    namvol2 = regexprep(namvol1,files_in.groups{1},files_in.groups{2});

    [hdr,vol1] = niak_read_vol(namvol1);
    [hdr,vol2] = niak_read_vol(namvol2);

    meanvol = ( (vol1.*files_in.n_size(1)) + (vol1.*files_in.n_size(2)) )./sum(files_in.n_size); %Weighted percentage
    diffvol = vol1-vol2;

    zscore = diffvol./sqrt( meanvol.*(1-meanvol).*((1/files_in.n_size(1))+(1/files_in.n_size(2))) );
    mask = abs(zscore) >  files_in.threshold;
    
    ovol = mask.*diffvol;
    hdr.file_name = regexprep(namvol1,files_in.groups{1},files_out);
    niak_write_vol(hdr,ovol);
end


end%function end