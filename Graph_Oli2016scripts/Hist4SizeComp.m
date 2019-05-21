%This script is meant to be used once a file has already been loaded.

fn = fieldnames(ShortSize.rest.CB.mat);
numCB = size(ShortSize.rest.CB.mat.(fn{1}).mat,2);
numSC = size(ShortSize.rest.SC.mat.(fn{1}).mat,2);

%loop for CB
TotCB = [];

for ff = 1:length(fn),
    ThrCB{ff} = [];
    for pp = 1:numCB
        temp = ShortSize.rest.CB.mat.(fn{ff}).mat{pp};
        
        TotCB = [TotCB temp];
        ThrCB{ff} = [ThrCB{ff} temp];
    end
end

%loop for SC
TotSC = [];

for ff = 1:length(fn),
    ThrSC{ff} = [];
    for pp = 1:numSC
        temp = ShortSize.rest.SC.mat.(fn{ff}).mat{pp};
        
        TotSC = [TotSC temp];
        ThrSC{ff} = [ThrSC{ff} temp];
    end
end

%lines for histograms
for ff = 1:length(fn),
    
    [nCB{ff} xOutCB{ff}] = hist(ThrCB{ff},[1:12 ]);
    nCB{ff} = nCB{ff}/numCB;

    [nSC{ff} xOutSC{ff}] = hist(ThrSC{ff},[1:12 ]);
    nSC{ff} = nSC{ff}/numSC;
end

%use bar(xOut, n) to see results
%ex.: bar(xOutCB{ii},nCB{ff}); figure, bar(xOutSC{ii},nSC{ff});