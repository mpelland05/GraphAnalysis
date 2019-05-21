function CompareTopographiesPipe(files_in,files_out,opt),
%This scripts goes through each atoms that are part of the analysis for
%each participants and compares the network linked to this atom to each
%other participants.
%This is done in two steps. First, the participant is compared to each
%other participant in his group (intra group score) then, he is compared to
%each other participants which are not part of his group (intere group
%score).
%
%The output contains de DiCe score, that is, the number of voxels that are
%shared between two networks which are composed of the atom of interest.
%Thus, for each atom, we find which network it is part of and calculate the
%amount of overlap between that network in one participant to taht network
%in another participant. 
%
%Should be faster than the first version of Compare Topographies. However,
%it only does comparison within the mask (so networks will be cut if they
%go outside the mask). 
%files_in
%   .mask  mask in which the analysis will be carried 0 for not carried and
%           1s for carried.
%   
%   .path       folder which contains the partion. 
%   
%   .atoms      full path to the roi.mnc.gz containing the atoms. 
%
%files_out  Path of folder with name of file in which the results will be saved.
%
%opt
%	.tpnames list of name of participants (name of the folder their data are in)
%
%	.GroupMat list of numbers (1 or 2) assigning the participants to a group.
%
%	.pType      type of partition to use, options are: adjusted, consensus,
%               core, theshold
%
%   	.filter     cell arrays of strins containing things to be removed ex: Task
%
%   	.groups     cell array of strings specifying the group ex: CBxxx
%
%   	.contrast   cell array of matrices specifying groups to be contrasted.
%               Self contrast is done automatically.
%
%   	.scales      matrix containing the scale(s) at which the analysis must be
%               carried
%                   OR
%               a 3 x number of scales matrix containing individual, group and final
%               number of clusters.
%
%Detailed output:
% Results
%   .Legend     Self explanatory
%   .VoxelsIdx  Location of tested voxels within the vome (space of
%               registered volume).
%   .Mask       Full path to the mask that was used to select the data of
%               interest
%   .PartitionType  The name of files that were used for the partition
%                   (such as consensus). 
%   .Filter     The group of participants that were excluded from the
%               analysis. Beware, if a group is left out of the analysis by
%               not specifying it in the opt.groups, there will not be
%               any mention of it being "filtered" out).
%   .Group      Names of the group that were analyzed
%   .Atoms      Full path to the volume containing the information about
%               the atoms.  
%
%Modified sept 16,2014 to had option for scales that are different at the
%individual, group and final level MP. 

fs = filesep;

%%%%%%%%
%find list of participants names using the .path
%%%%%%%%
if ~exist('opt','var'),
    tdir = dir(files_in.path);
    tnam = find(vertcat(tdir.isdir));

    for tt = tnam(3:length(tnam))',
    	tpnames{tt-2} = tdir(tt).name;
    end
else 
     tpnames = opt.tpnames;
end

%%%%%
%Remove participants/run using the .filter argument
%%%%%
ReMat = zeros(length(tpnames),length(opt.filter));

for ff = 1:length(opt.filter),
    ReMat(:,ff) = not(cellfun('isempty',strfind(tpnames,opt.filter{ff})));
end

pnames = tpnames(find(sum(ReMat,2)==0));


%%%%%%
%Set group for each participant
%%%%%%
if ~exist('opt','var'),
    GroupMat = zeros(1,length(pnames));
    for gg = 1:length(opt.groups),
        GroupMat(not(cellfun('isempty',strfind(pnames,opt.groups{gg})))) = gg;
    end
else
    GroupMat = opt.GroupMat;
end

%%%%%
% Load mask and save indexes
%%%%%
'loading mask'
[hdr mask] = niak_read_vol(files_in.mask);
Loc = find(mask == 1);
clear mask


%%%%%
% Load atoms and same them
%%%%
'loading atoms'
[hdr atoms] = niak_read_vol(files_in.atoms);
Atom = atoms(Loc);
uAtom = unique(Atom);
clear atoms

%%%%%
% Prepare the results structure
%%%%
Results.Legend = {'VoxelsIdx: Index of the voxels of interest';'Mask: Mask used to determine which voxels to use';'Path: Path to the partitions to use' ...
                    ;'PartitionType: Which file from the path is used for the partitions'; 'Filter: String that will be used to removed folders of non-interest'...
                    ;'Group: Names of the groups'; 'ParticipantsIdx: Index of participants names and groups to which they are affiliated'
                    ;'Atoms: link to the files containing the atoms (or smallest brain partition used'};
                
Results.VoxelsIdx = Loc; 
Results.Atoms = files_in.atoms;
Results.ParticipantsIdx.Names = pnames;
Results.ParticipantsIdx.Groups = GroupMat;
Results.Parameters.Mask = files_in.mask;
Results.Parameters.Path = files_in.path;
Results.Parameters.PartitionType = opt.pType;
Results.Parameters.Filter = opt.filter;
Results.Parameters.Group = opt.groups;
Results.Contrast_Legend = {'VoxelsIdx x Participtants Group 1 x Participants Group 2'};




%%%%%
% Loop for calculating self overlap
%%%%%

for ss = 1:size(opt.scales,2),%scales
    
    if size(opt.scales,1) == 1,
        ScaleStr = strcat('sci',num2str(opt.scales(ss)),'_scf',num2str(opt.scales(ss)))
    else
        ScaleStr = strcat('sci',num2str(opt.scales(1,ss)),'_scf',num2str(opt.scales(3,ss)))
    end
    
    % Load all data into matrices Voxel x Participant.
    'Creating Voxel x Participant matrix'
    for gg = 1:length(opt.groups),%groups
        PartIdx = find(GroupMat == gg);
    
        Group{gg} = zeros( length(Loc), length(PartIdx) );
    
        for pp = 1:length(PartIdx),
            [gg pp]
            [hdr Target] = niak_read_vol( strcat(files_in.path,fs,pnames{PartIdx(pp)},fs,ScaleStr,fs,'brain_partition_',opt.pType,'_ind_',pnames{PartIdx(pp)},'_',ScaleStr,'.mnc') );% 
            
            Group{gg}(:,pp) = Target(Loc);
            
            clear Target;
        end
    end
    
    
    %SELF!!!!
    'Starting self'
    
    for gg = 1:length(opt.groups),%groups
    
        Results.(ScaleStr).(strcat('Self_',opt.groups{gg})) = zeros(length(Loc),size(Group{gg},2),size(Group{gg},2));
    
        for pph = 1:size(Group{gg},2),%horizon of matrix
            for ppv = 1:size(Group{gg},2),  %Vertical of matri
                
                [gg pph ppv]
                
                for uu = 1:length(uAtom),
                    
                    aLoc = find(Atom == uAtom(uu));
                    
                    NetTarget = Group{gg}(aLoc(1), pph);
                    NetVol = Group{gg}(aLoc(1), ppv);
                    
                    tLoc = find( Group{gg}(:, pph) == NetTarget);
                    vLoc = find( Group{gg}(:, ppv) == NetVol);
                    
                    NumTarget = length(tLoc);
                    NumVol = length(vLoc);
                    
                    NumTV = length(intersect(tLoc,vLoc));
                    
                    tDice = (2.*NumTV)/(NumTarget+NumVol);
                    
                    Results.(ScaleStr).(strcat('Self_',opt.groups{gg}))(aLoc,pph,ppv) = tDice;
                end
            end
        end
    end


    %OTHER !!!!
    'Starting group comparisons'
    
    for gg = 1:length(opt.groups),%groups
        %Make list of other groups
        List2ndGroup = 1:length(opt.groups); List2ndGroup(List2ndGroup == gg) = [];
        
        
        for gg2 = List2ndGroup,%other groups
            
            Results.(ScaleStr).(strcat( opt.groups{gg},'_vs_',opt.groups{gg2} )) = zeros(length(Loc),size(Group{gg},2),size(Group{gg2},2));
            
            
            for pph = 1:size(Group{gg},2),%horizon of matrix
                for ppv = 1:size(Group{gg2},2),  %Vertical of matrix
                    
                    [gg gg2 pph ppv]
                    
                    for uu = 1:length(uAtom),
                    
                        aLoc = find(Atom == uAtom(uu));
                    
                        NetTarget = Group{gg}(aLoc(1), pph);
                        NetVol = Group{gg2}(aLoc(1), ppv);  
                    
                        tLoc = find( Group{gg}(:, pph) == NetTarget);
                        vLoc = find( Group{gg2}(:, ppv) == NetVol);
                    
                        NumTarget = length(tLoc);
                        NumVol = length(vLoc);
                    
                        NumTV = length(intersect(tLoc,vLoc));
                    
                        tDice = (2.*NumTV)/(NumTarget+NumVol);
                    
                        Results.(ScaleStr).(strcat( opt.groups{gg},'_vs_',opt.groups{gg2} ))(aLoc,pph,ppv) = tDice;
                    end
                end
            end
        end
    end
end

save(files_out,'Results');


end
