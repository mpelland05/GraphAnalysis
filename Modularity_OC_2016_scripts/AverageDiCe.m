function AverageDiCe(files_in,files_out),
%This script takes the results from CompareTopographies and average the
%DiCe score accross participants. Thus, instead of having a nVoxels x N x N
%matrix (where each participant is compared to each other participant), 
%there will be a nVoxels x N matrix (Where you get a single score per participant 
%showing how he compare on average with the others). This is done both at
%the intra and inter group level leading to as many matrices as there are
%comparisions possible. 
%
%
%files_in
%   .scales      matrix containing the scale(s) at which the analysis must be
%               carried
%                   OR
%               a 3 x number of scales matrix containing individual, group and final
%               number of clusters.

%       .groups     cell array of strings specifying the group ex: CBxxx
%       .path       string leading to the .mat file used by the script
%
%files_out          string containing path and name in which results will be saved. 
%
%See CompareTopographies for more information.


load(files_in.path);

Avg.Legend = Results.Legend;
Avg.Atoms = Results.Atoms;
Avg.VoxelsIdx = Results.VoxelsIdx;
Avg.ParticipantsIdx = Results.ParticipantsIdx;
Avg.Parameters = Results.Parameters;

                
                

for ss = 1:size(files_in.scales,2),%scales
    
    if size(files_in.scales,1) == 1,
        ScaleStr = strcat('sci',num2str(files_in.scales(ss)),'_scf',num2str(files_in.scales(ss)))
    else
        ScaleStr = strcat('sci',num2str(files_in.scales(1,ss)),'_scf',num2str(files_in.scales(3,ss)))
    end
    
    
    for gg = 1:length(files_in.groups),
        
        tname = strcat('Self_',files_in.groups{gg});
        [aa bb len] = size(Results.(ScaleStr).(tname));
        Avg.(ScaleStr).(tname) = (sum(Results.(ScaleStr).(tname),3)-1)./(len-1);
        
    end
    
    
    
    for gg = 1:length(files_in.groups),
        
        List2ndGroup = 1:length(files_in.groups); List2ndGroup(List2ndGroup == gg) = [];
        
        for gg2 = List2ndGroup,
            
            tname = strcat( files_in.groups{gg},'_vs_',files_in.groups{gg2} )
            
            [aa bb len] = size(Results.(ScaleStr).(tname));
            Avg.(ScaleStr).(tname) = mean(Results.(ScaleStr).(tname),3);
        end
    end
    
    save(files_out,'Avg');
    
end
end

%files_in.scales = 100;
%files_in.groups = {'CBxxx','SCxxx'};
%files_in.path = 'F:\Modularity\Results\ValTest.mat'
%files_out = 'F:\Modularity\Results\AvgValTest.mat';