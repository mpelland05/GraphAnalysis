function MapQValues(files_in,files_out),
%This script takes p-values from a selected .mat files and applies fdr
%correction (LSL) to the values (which are non zero). It then proceeds to
%write volumes containing the resulting q-values for each voxel.
%
%files_in
%   .path       string, full path to the .mat file which contains the 
%               results that need to be mapped. 
%   .scale      ....
%   
%files_out      string, Path of folder with name of file in which the results will be saved.
%
%Output:        Two volumes, one with unsigned q-values, and one with
%               negative and positive q-values.
%
%Old output which is not longer used:
%Output legend: the unmodified file name is the whole 1-qvalues 
%               The others end with two informations S (self) and G
%               (group) and each is attributed a sign (pos or neg). For
%               example, SposGneg will stand for a positive DiCe for the
%               self (Self - Other > 0) and a negative difference between
%               the groups (G1 (Self - Other) < G2 (Self - Other))

load(files_in.path)

[hdr vol] = niak_read_vol(Perm.Parameters.Mask);
vol = zeros(size(vol));


%Remove p-values that equal 0
if isfield(files_in,'scale')
    Loc = find(Perm.(strcat('CBvsSC_',num2str(files_in.scale))).pvalues ~= 0);
    pvalues = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).pvalues(Loc);
else
    Loc = find(Perm.(strcat('CBvsSC_',files_in.ScaleStr)).pvalues ~= 0);
    pvalues = Perm.(strcat('CBvsSC_',files_in.ScaleStr)).pvalues(Loc);
end

%Find q-values
[qtemp test] = niak_fdr(pvalues,'LSL', 0.05);   %find q-values for subset of voxels Idx which did not have a p-value of 0
qtemp = (1-qtemp).*(test);                    % Get opposite to obtain nice maps

if isfield(files_in,'scale')
    qvalues = zeros(size( Perm.(strcat('CBvsSC_',num2str(files_in.scale))).pvalues )); 
else
    qvalues = zeros(size( Perm.(strcat('CBvsSC_',files_in.ScaleStr)).pvalues )); 
end
qvalues(Loc) = qtemp;

vol(Perm.VoxelsIdx) = qvalues;

%Write volume with signed q-values
if isfield(files_in,'scale')
    Avg = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).Average;
else
    Avg = Perm.(strcat('CBvsSC_',files_in.ScaleStr)).Average;
end
PoNe = zeros(size(Avg));
PoNe(Avg > 0) = 1; PoNe(Avg < 0) = -1;

qvalues = qvalues.*PoNe;
vol(Perm.VoxelsIdx) = qvalues;

%Write volume with all q-values
hdr.file_name = strcat(files_out,'.nii.gz');
niak_write_vol(hdr,vol)


%%%%%Easy launching lines:
%bb = '/home/mpelland/database/blindModularity/Results/RestOnly_CBSCMixed_Whole_RightOnly/Permutated/Perm_RestOnly_CBSCMixed_Whole_RightOnly';
%files_in.ScaleStr = 'sci180_scf197';
%files_in.path = strcat(bb,files_in.ScaleStr,'_Paired.mat');
%files_out = strcat(bb,files_in.ScaleStr,'_Paired');


%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%Old stuff %%%%

%%Create subplots
%CB = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).Average.CBxxx;
%SC = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).Average.SCxxx;



%Write volume with q-value only when SelfCB > CBvsSC and CB - SC > 0
%temp = qvalues.*test.*(CB > 0).*((CB-SC)>0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SposGpos.nii.gz');
%niak_write_vol(hdr,vol)

%Write volume with q-value only when SelfCB > CBvsSC and CB - SC < 0
%temp = qvalues.*test.*(CB > 0).*((CB-SC)<0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SposGneg.nii.gz');
%niak_write_vol(hdr,vol)

%Write volume with q-value only when SelfCB < CBvsSC and CB - SC > 0
%temp = qvalues.*test.*(CB < 0).*((CB-SC)>0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SnegGpos.nii.gz');
%niak_write_vol(hdr,vol)

%Write volume with q-value only when SelfCB < CBvsSC and CB - SC < 0
%temp = qvalues.*test.*(CB < 0).*((CB-SC)<0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SnegGgeg.nii.gz');
%niak_write_vol(hdr,vol)
end