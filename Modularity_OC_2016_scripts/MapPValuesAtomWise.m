function MapPValuesAtomWise(files_in,files_out),
%files_in
%   .path       folder which contains the partion. 
%   .scale      or files_in.ScaleStr
%               int for scale, and a string of 'sci5_scf5'just replace the
%               number 5 with the actual size of the thing.
%   .p          theshold for test
%
%files_out  Path of folder with name of file in which the results will be saved.
%Output legend: the unmodified file name is the whole 1-qvalues 
%               The others end with two informations S (self) and G
%               (group) and each is attributed a sign (pos or neg). For
%               example, SposGneg will stand for a positive DiCe for the
%               self (Self - Other > 0) and a negative difference between
%               the groups (G1 (Self - Other) < G2 (Self - Other))
%
%This script differs from the MapQValues in that it does its analysis at
%the atom level, not at the voxel level. 
%
%Launching lines
%
%files_in.ScaleStr = 'sci4_scf3';  
%bb ='/home/mpelland/database/blindModularity/Results/RestOnly_CBSCMixed_OccMask_LeftOnly/Permutated/Perm_RestOnly_CBSCMixed_OccMask_LeftOnly';
%files_in.path = strcat(bb,files_in.ScaleStr,'_Paired.mat');
%files_out = strcat(bb,files_in.ScaleStr,'_Paired');
%MapQValuesAtomWise(files_in,files_out)

load(files_in.path)

%Load mask
[hdr vol] = niak_read_vol(Perm.Parameters.Mask);
vol = zeros(size(vol));


%Load Atoms
[hdr Atm] = niak_read_vol(Perm.Atoms);
Atom = Atm(Perm.VoxelsIdx);clear Atm;
uAtom = unique(Atom);
uAtom(find(uAtom == 0)) = [];

for uu = 1:length(uAtom),
    temp = find( Atom == uAtom(uu) );
    Loc(uu) = temp(1);      
end


%Get P-values but only for a single voxels within each atoms
if isfield(files_in,'scale')
    pvalues = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).pvalues(Loc);
else
    pvalues = Perm.(strcat('CBvsSC_',files_in.ScaleStr)).pvalues(Loc);
end

%Find q-values
[qtemp test] = niak_fdr(pvalues(:),'BH', files_in.p);   %find q-values for subset of voxels Idx which did not have a p-value of 0
test = pvalues < files_in.p;
qtemp = (pvalues).*(test);
%qtemp = (1-qtemp).*(test);                    % Get opposite to obtain nice maps


%Unsqueeze information from atom to voxels
if isfield(files_in,'scale')
    qvalues = zeros(size( Perm.(strcat('CBvsSC_',num2str(files_in.scale))).pvalues )); 
else
    qvalues = zeros(size( Perm.(strcat('CBvsSC_',files_in.ScaleStr)).pvalues )); 
end


for uu = 1:length(uAtom),
    temp = find( Atom == uAtom(uu) );
    
    qvalues(temp) = qtemp(uu);
end


%fill volume with qvalues
vol(Perm.VoxelsIdx) = qvalues;


%Write volume with all q-values
%hdr.file_name = strcat(files_out,'_all.mnc.gz');
%niak_write_vol(hdr,vol)


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

hdr.file_name = strcat(files_out,'_signed_P.mnc.gz');
niak_write_vol(hdr,vol)

%%%Old stuff %%%%

%%Create subplots
%CB = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).Average.CBxxx;
%SC = Perm.(strcat('CBvsSC_',num2str(files_in.scale))).Average.SCxxx;



%Write volume with q-value only when SelfCB > CBvsSC and CB - SC > 0
%temp = qvalues.*test.*(CB > 0).*((CB-SC)>0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SposGpos.mnc.gz');
%niak_write_vol(hdr,vol)

%Write volume with q-value only when SelfCB > CBvsSC and CB - SC < 0
%temp = qvalues.*test.*(CB > 0).*((CB-SC)<0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SposGneg.mnc.gz');
%niak_write_vol(hdr,vol)

%Write volume with q-value only when SelfCB < CBvsSC and CB - SC > 0
%temp = qvalues.*test.*(CB < 0).*((CB-SC)>0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SnegGpos.mnc.gz');
%niak_write_vol(hdr,vol)

%Write volume with q-value only when SelfCB < CBvsSC and CB - SC < 0
%temp = qvalues.*test.*(CB < 0).*((CB-SC)<0);
%temp = 1-temp;temp(find(temp == 1)) = 0;
%vol = zeros(size(vol)); vol(Perm.VoxelsIdx) = temp;
%hdr.file_name = strcat(files_out,'_SnegGgeg.mnc.gz');
%niak_write_vol(hdr,vol)

end
%files_in.scale = 4;
%files_in.path = '/home/mpelland/database/blindModularity/Results/PermFirstTest.mat';
%files_out = '/home/mpelland/database/blindModularity/Results/MapPValueFirstTest';



