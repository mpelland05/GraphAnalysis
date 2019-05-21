Seeds = [21 96 99 82 88 26 80 40 62 65];%Seeds to investigate
Groups = {[1:14] [15:24] [25:40]}; %enter the subject numbers for each group
GNames = {'CB','LB','SC'};%Cells containing names of the groups.

Reshape = 1; % 1 to be done, 0 not done. This will remove the Seeds from the analysis.

%%%%%%%%%%%%%%%%%%%%%%%%
% Create list of names %
%%%%%%%%%%%%%%%%%%%%%%%%
data.group      = {'connectome_CBxxx','connectome_LBxxx','connectome_SCxxx'};
data.subs_CB    = {'VDAlCh','VDAnBe','VDBeMe','VDDiCe','VDFrCo','VDLL','VDMaLa','VDMaDu','VDMoBe','VDNaTe','VDSePo','VDSoSa','VDYP','VDYvLa'}; % n = 14                                     
data.subs_LB    = {'VDCaMa','VDDeBe','VDGiCo','VDJoBi','VDJoBo','VDJoGa','VDLiJo','VDLiVe','VDMoLa','VDRaDe'}; % n = 11
data.subs_SC    = {'VDCJ','VDChJa','VDClDe','VDGeAl','VDJM','VDJeRe','VDJoFr','VDKaFo','VDLALH','VDMaSa','VDNiLe','VDNiMi','VDOL','VDPG','VDSG','VDTJ'}; % n = 17

ll = 1; %incrementation variable.
for n1 = 1:length(data.subs_CB)
    names{ll} = strcat(data.group{1},data.subs_CB{n1},'_sci100_scg100_scf100.mat');
    ll = ll +1;
end
for n1 = 1:length(data.subs_LB)
    names{ll} = strcat(data.group{2},data.subs_LB{n1},'_sci100_scg100_scf100.mat');
    ll = ll +1;
end
for n1 = 1:length(data.subs_SC)
    names{ll} = strcat(data.group{3},data.subs_SC{n1},'_sci100_scg100_scf100.mat');
    ll = ll +1;
end
clear ll;


for ii = 1:length(GNames),
    kk = 0;
    Res.(GNames{ii}).cMat = zeros(100,90,length(Groups{ii}));
    
    for jj = Groups{ii},
        kk = kk+1;
        load(names{jj});
        
        if Reshape,
            temp = SquareAnArray2(rest_CB.connectome,100);
            loc = 1:100;loc(Seeds) = [];
            Res.(GNames{ii}).cMat(:,:,kk) = temp(:,loc);
        else
            Res.(GNames{ii}).cMat(:,:,kk) = SquareAnArray2(rest_CB.connectome,100);   
        end
        
    end
end

%%%% Histogram stuff %%%%
for ii = 1:length(Groups), %size of the matrix
    
        [xx yy zz] = size(Res.(GNames{ii}).cMat);
        
        Res.(GNames{ii}).hist.hMat = zeros(xx, length(-.7:.1:1.9), zz);
        
        
        for kk = 1:zz,
            for ll = 1:xx,
                [nn xout] = hist(Res.(GNames{ii}).cMat(ll,:,kk),-.7:.1:1.9);
                Res.(GNames{ii}).hist.hMat(ll,:,kk) = nn;
            end
        end
        
        %Record hist stuff
        Res.(GNames{ii}).hist.Legend = 'Seeds x bins x individual for Average, standard deviation of each bins of the histogram, xout is the middle of the bins for the histograms';
        Res.(GNames{ii}).hist.Avg = mean(Res.(GNames{ii}).hist.hMat,3);
        Res.(GNames{ii}).hist.Std = std(Res.(GNames{ii}).hist.hMat,0,3);
        Res.(GNames{ii}).hist.xout = xout;
end

        
%Record mean and median stuff
for ii = 1:length(Groups), %size of the matrix
        
        [xx yy zz] = size(Res.(GNames{ii}).cMat);
        Res.(GNames{ii}).hist.MeanMedian.meanMat = zeros(xx, zz);
        Res.(GNames{ii}).hist.MeanMedian.mediMat = zeros(xx, zz);
        
        Res.(GNames{ii}).hist.MeanMedian.meanMat(:,:) = squeeze(mean(Res.(GNames{ii}).cMat, 2));
        Res.(GNames{ii}).hist.MeanMedian.mediMat(:,:) = squeeze(median(Res.(GNames{ii}).cMat, 2));
            
        Res.(GNames{ii}).hist.MeanMedian.Legend = 'Seeds x Participant Mean and median connectivity of each seed with all other seeds';
 
end












