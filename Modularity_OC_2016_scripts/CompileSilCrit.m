function CompileSilCrit(files_in),
%This script will take results from the individual clustering process (from
%BASC) and compile the silhouette criterion into one file.
%
%files_in
%       .path   string with the full path to the individual results
%               directory
%       .groups cell of strings with name of groups. 

fs = filesep;

%%%%%%%%
%find list of participants names using the .path
%%%%%%%%
tdir = dir(files_in.path);
tnam = find(vertcat(tdir.isdir));

for tt = tnam(3:length(tnam))',
    tpnames{tt-2} = tdir(tt).name;
end

pnames = tpnames;

%%%%%%
%Set group for each participant
%%%%%%
GroupMat = zeros(1,length(pnames));
for gg = 1:length(files_in.groups),
    GroupMat(not(cellfun('isempty',strfind(pnames,files_in.groups{gg})))) = gg;
end

%%%%%%
% Main process
%%%%%

CompSil =struct();

for gg = 1:length(files_in.groups),
   tnames = pnames(find(GroupMat == gg));
    
   load(strcat(files_in.path,tnames{1},fs,'stability_ind_',tnames{1},'.mat'), 'sil')
   CompSil.(files_in.groups{gg}).Sil = zeros(size(sil,1),size(sil,2),length(tnames));
  
   for ii = 1:length(tnames),
      load(strcat(files_in.path,tnames{ii},fs,'stability_ind_',tnames{ii},'.mat'), 'sil')
      CompSil.(files_in.groups{gg}).Sil(:,:,ii) = sil;
   end
end

save(strcat( files_in.path,'CompiledSil.mat' ), 'CompSil' );    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%files_in.path = '/home/mpelland/database/blindModularity/fmri/basc_RestOnly_CBSCMixed_OccMask_LeftOnly/stability_ind/';

%files_in.groups = {'CBxxx','SCxxx'};
