function CompareTopographies_fromParts(files_in,files_out),
%This script is a modified version from the original CompareTopographies in
%order to accomodate data from the GraphAnalysis Modularity output. 
%
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
%   .path       folder which contains the partion. 
%   .p1         cells of strings ex: {'rest' 'CB'};
%   .p2         cells of strings ex: {'rest' 'SC'};
%   .atoms      full path to the roi.mnc.gz containing the atoms. 
%
%files_out  Path of folder with name of file in which the results will be saved.
%
%Detailed output:
% Results
%   .Legend     Self explanatory
%   .VoxelsIdx  Location of tested voxels within the vome (space of
%               registered volume).
%   .Mask       Full path to the mask that was used to select the data of
%               interest
%   .Atoms      Full path to the volume containing the information about
%               the atoms.  
%
%Modified sept 16,2014 to had option for scales that are different at the
%individual, group and final level MP. 

fs = filesep;

p1 = files_in.p1;
p2 = files_in.p2;

%%%%%
% Load the data file
%%%%%
load(files_in.path);

%%%%%
% Loop for calculating self overlap
%%%%%
fn = fieldnames( HierClustersInd.(p1{1}).(p1{2}).(ext) );

for ff = 1:length(fn),
    
    %SELF!!!!
    'Starting self'
    for cc = 1:2,
      eval(strcat( 'tcond=p',num2str(cc),'{1};'  ));
      
      for gg = 1:2,%groups
        eval(strcat( 'tgroup=p',num2str(gg),'{2};'  ));
        
        [xx yy nPart] = size(HierClustersInd.(tcond).(tgroup).(ext).(fn{ff}).mat);
        
        Results.(fn{ff}).(strcat('Self_',tgroup) = zeros(xx,nPart,nPart);%zeros(length(Loc),size(Group{gg},2),size(Group{gg},2));
    
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
                    
                    Results.(ScaleStr).(strcat('Self_',files_in.groups{gg}))(aLoc,pph,ppv) = tDice;
                end
            end
        end
    end
    end

    %OTHER !!!!
    'Starting group comparisons'
    
    for gg = 1:length(files_in.groups),%groups
        %Make list of other groups
        List2ndGroup = 1:length(files_in.groups); List2ndGroup(List2ndGroup == gg) = [];
        
        
        for gg2 = List2ndGroup,%other groups
            
            Results.(ScaleStr).(strcat( files_in.groups{gg},'_vs_',files_in.groups{gg2} )) = zeros(length(Loc),size(Group{gg},2),size(Group{gg2},2));
            
            
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
                    
                        Results.(ScaleStr).(strcat( files_in.groups{gg},'_vs_',files_in.groups{gg2} ))(aLoc,pph,ppv) = tDice;
                    end
                end
            end
        end
    end
end

save(files_out,'Results');


end
