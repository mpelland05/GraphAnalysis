function MapPValues(files_in,files_out),
%files_in
%   .path       folder which contains the partion. 
%   
%files_out  Path of folder with name of file in which the results will be saved.

load(files_in.path);

[hdr vol] = niak_read_vol(Perm.Parameters.Mask);

hdr.file_name = strcat(files_out,'.nii.gz');

vol = zeros(size(vol));

vol(Perm.VoxelsIdx) = Perm.CBvsSC_100.pvalues;

niak_write_vol(hdr,vol);

end

%files_in.path = '/home/mpelland/database/blindModularity/Results/PermFirstTest.mat';
%files_out = '/home/mpelland/database/blindModularity/Results/MapPValueFirstTest.nii.gz';