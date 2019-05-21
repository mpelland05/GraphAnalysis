bP = 'F:\Connectivity\GraphTheory\';
subP = {'Rest','Task'};
pP = {'Perc_10','Perc_20','Perc_30','Perc_40','Perc_50','Perc_80'};
nSeeds = 10;
Seeds = [21    26    40    62    65    80    82    88    96    99];

Groups = {'CB', 'LB', 'SC'};

Comp.Legend = 'Theshold x seeds';


for aa = 1:length(subP),
    for cc = 1:length(Groups),
    
    Comp.(Groups{cc}).(subP{aa}).Betweenness.Avg = zeros(length(pP),nSeeds);
    Comp.(Groups{cc}).(subP{aa}).Betweenness.Std = zeros(length(pP),nSeeds);

    
        for bb = 1:length(pP),
            load(strcat(bP,subP{aa},'\',pP{bb},'\','connectomes\Compiled_betweenness.mat'));
        
            tm = mean(Bet.(Groups{cc}).bMat);
            ts = std(Bet.(Groups{cc}).bMat);
            
            Comp.(Groups{cc}).(subP{aa}).Betweenness.Avg(bb,:) = tm(Seeds);
            Comp.(Groups{cc}).(subP{aa}).Betweenness.Std(bb,:) = ts(Seeds);

        end
    end
end


save(strcat(bP,'GraphBetweennessMultipleThreshold.mat'),'Comp');