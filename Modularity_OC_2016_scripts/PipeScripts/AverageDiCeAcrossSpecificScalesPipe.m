function AverageDiCeAcrossSpecificScalesPipe(files_in,files_out,opt),
%This script will take the output of DiCe score calculator, and put it in a
%format which will be an average of all scales, this is done to have a
%
%Note: issues will occur if the there are more sparsities than voxels
%studied
%
%single map rather than multiple maps at multiple parsities. <
%
%
%files_in = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/avg_OutputCmpTopo.mat'; file containing a structure name Avg 
%files_out = ''; % full path to output file
%opt.scales = {'sci1_scf1'}; string that will choose subfields of Avg to average
%opt.name = 'LowScales';%simple name for output variable

load(files_in);

fn = opt.scales;

switcher = 1;
counter = 0;

for ff = 1:length(fn),
        counter = counter + 1; %count the number of scales
        
        %short loop to set up variables
        if switcher,
            switcher = 0;
            groups = fieldnames(Avg.(fn{ff}));
            for gg = 1:length(groups),
                Avg.(opt.name).(groups{gg}) = zeros(size(Avg.(fn{ff}).(groups{gg})));
            end
        end
        
        %main loop to fill in variables
        for gg = 1:length(groups),
            Avg.(opt.name).(groups{gg}) = Avg.(opt.name).(groups{gg}) + Avg.(fn{ff}).(groups{gg});
        end
end

for gg = 1:length(groups),
    Avg.(opt.name).(groups{gg}) = Avg.(opt.name).(groups{gg})./counter;
end


save(files_out,'Avg');
end