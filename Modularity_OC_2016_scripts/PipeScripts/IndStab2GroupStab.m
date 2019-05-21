%Take already calculated individual stability to get a group stability.
%This is not done using the usual pipeline since analysis were first ran by
%grouping the two populations together. Thus, this pipeline runs on each
%groups to get a separate set group stability maps for each group. 
%
%Inputs
%files_in
%       .path       string, full path to the folder containing the folder
%                   with results for the individual stability analysis (so
%                   folder containing folders named after each participants
%                   and containing parcellation that were drawn
%                   individually for each participants).
%       .groups     cell of strings, name of the different groups for which
%                   a map will be drawn. 
%       .info       cell of strings, for each group, a model of the group
%                   must be specified. This is the same model as for the
%                   original basc analysis but only including the
%                   participants of the group of interest (so, there is one
%                   model per group for which a map will be drawn).
%       .rand_seed  Set the number that will be used for randomization.
%
%Output         .mat file consisting of the necessary information to draw a
%                   map using 
%
%Note: this script uses: niak_brick_stability_group_maxime instead of the
%       script developped by P.Bellec.
%
%To actually obtain the maps see LaunchMapping_Rest_onlyCBSCMixed, all
%values should be self explanatory. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = filesep;

%%%%%%%%
%find list of participants names using the .path
%%%%%%%%
tdir = dir(strcat(mfiles_in.path,fs,'stability_ind',fs));
tnam = find(vertcat(tdir.isdir));

for tt = tnam(3:length(tnam))',
    tpnames{tt-2} = tdir(tt).name;
end

pnames = tpnames;

GroupMat = zeros(1,length(pnames));
for gg = 1:length(mfiles_in.groups),
    GroupMat(not(cellfun('isempty',strfind(pnames,mfiles_in.groups{gg})))) = gg;
end



%Loop for groups
for gg = 1:length(mfiles_in.groups),
    pLoc = find(GroupMat == gg);
    for pp = 1:sum(GroupMat == gg),
        files_in.stability.( pnames{pLoc(pp)} ) = strcat( mfiles_in.path,'stability_ind',fs,pnames{pLoc(pp)},fs,'stability_ind_',pnames{pLoc(pp)},'.mat');
    end
    files_in.info = mfiles_in.info{gg};
    mkdir(mfiles_in.path,strcat('stability_group_',mfiles_in.groups{gg}));
    files_out = strcat(mfiles_in.path,'stability_group_',mfiles_in.groups{gg},fs,'stability_group_',mfiles_in.groups{gg},'_',num2str(opt.nb_classes_final),'.mat');
    
    [files_in,files_out,opt] = niak_brick_stability_group_maxime(files_in,files_out,opt);
    clear files_in
end

%NIAK_BRICK_STABILITY_GROUP

%niak_brick_stability_maps