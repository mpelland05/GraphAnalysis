bP = 'F:\Connectivity\GraphTheory\';
subP = {'Rest','Task'};
pP = {'Perc_10','Perc_20','Perc_30','Perc_40','Perc_50','Perc_80'};
nSeeds = 10;

Groups = {'CB', 'LB', 'SC'};

Comp.Legend = 'Theshold x seeds';


for aa = 1:length(subP),
    for cc = 1:length(Groups),
    
    Comp.(Groups{cc}).(subP{aa}).Centrality.Avg = zeros(length(pP),nSeeds);
    Comp.(Groups{cc}).(subP{aa}).Centrality.Std = zeros(length(pP),nSeeds);

    Comp.(Groups{cc}).(subP{aa}).Clustering.Avg = zeros(length(pP),nSeeds);
    Comp.(Groups{cc}).(subP{aa}).Clustering.Std = zeros(length(pP),nSeeds);

    Comp.(Groups{cc}).(subP{aa}).Efficiency.Avg = zeros(length(pP),nSeeds);
    Comp.(Groups{cc}).(subP{aa}).Efficiency.Std = zeros(length(pP),nSeeds);
    
        for bb = 1:length(pP),
            load(strcat(bP,subP{aa},'\',pP{bb},'\','graph_prop\Compiled_properties.mat'));
        
            Comp.(Groups{cc}).(subP{aa}).Centrality.Avg(bb,:) = mean(Results.(Groups{cc}).Centrality);
            Comp.(Groups{cc}).(subP{aa}).Centrality.Std(bb,:) = std(Results.(Groups{cc}).Centrality);

            Comp.(Groups{cc}).(subP{aa}).Clustering.Avg(bb,:) = mean(Results.(Groups{cc}).Clustering);
            Comp.(Groups{cc}).(subP{aa}).Clustering.Std(bb,:) = std(Results.(Groups{cc}).Clustering);
            
            Comp.(Groups{cc}).(subP{aa}).Efficiency.Avg(bb,:) = mean(Results.(Groups{cc}).Efficiency);
            Comp.(Groups{cc}).(subP{aa}).Efficiency.Std(bb,:) = std(Results.(Groups{cc}).Efficiency);

        end
    end
end


save(strcat(bP,'GraphPropertiesMultipleThreshold.mat'),'Comp');