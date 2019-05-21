function AverageDiCeAcrossScales(files_in),
%This script will take the output of DiCe score calculator, and put it in a
%format which will be an average of all scales, this is done to have an
%omnibus test
%
%Note: issues will occur if the there are more sparsities than voxels
%studied
%
%single map rather than multiple maps at multiple parsities. <
%files_in.string = '_scf'; string that will allow to disambiguate the scales from other variabes
%files_in.file = ''; file containing a structure name Avg 

load(files_in.file);

fn = fieldnames(Avg);

switcher = 1;
counter = 0;

for ff = 1:length(fn),
    
    if ~isempty(strfind(fn{ff},files_in.string)),
        counter = counter + 1; %count the number of scales
        
        %short loop to set up variables
        if switcher,
            switcher = 0;
            groups = fieldnames(Avg.(fn{ff}));
            for gg = 1:length(groups),
                Avg.AllScales.(groups{gg}) = zeros(size(Avg.(fn{ff}).(groups{gg})));
            end
        end
        
        %main loop to fill in variables
        for gg = 1:length(groups),
            Avg.AllScales.(groups{gg}) = Avg.AllScales.(groups{gg}) + Avg.(fn{ff}).(groups{gg});
        end
    end
end

for gg = 1:length(groups),
    Avg.AllScales.(groups{gg}) = Avg.AllScales.(groups{gg})./counter;
end

save(strcat(files_in.file(1:end-4),'_wAvg.mat'),'Avg');
end