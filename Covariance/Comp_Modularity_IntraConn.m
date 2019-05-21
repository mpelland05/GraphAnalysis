AnalName = 'Modularity'%Name of analysis

%This script will compute modularity, community and number of networks over
%a set number (100) of iterations of the modularity algorithm.

%Please specify sMod, sCom, sNet, sProp and sPrev (0 or 1) where 1 will get


if exist(strcat( OutP,'Modularity.mat' )) == 2,load(strcat( OutP,'Modularity.mat' ));end
if exist(strcat( OutP,'Community.mat' )) == 2,load(strcat( OutP,'Community.mat' ));end
if exist(strcat( OutP,'NNet.mat' )) == 2,load(strcat( OutP,'NNet.mat' ));end
if exist(strcat( OutP,'PropIntra.mat' )) == 2,load(strcat( OutP,'PropIntra.mat' ));end
if exist(strcat( OutP,'PrevIntra.mat' )) == 2,load(strcat( OutP,'PrevIntra.mat' ));end

for ee = 1:length(ext),
for cc = 1:length(Cond),
   for gg = 1:length(Groups),
      [xx yy numPart] = size(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee}));%get num of participants
      
      for ll = 1:length(Thr),
          
        %Create result mat
        Modularity.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(1,numPart);
        Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(xx,xx,numPart);
        NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(1,numPart);
        PropIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(1,numPart);
        PrevIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(1,numPart);
          
        for kk = 1:numPart,
            temp =  ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee})(:,:,kk);
            
            if exist('fmst'),if fmst & strcmp(MakeBinar,'no'),
                temp = temp + ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
            end;end;
            
            %get information of current AND next threshold on current community
            [mat thresh] = s02_Thresh(temp,'single','useless',Thr(ll), MakeBinar, Fisc); %Binarize matrix
            if ll < length(Thr), [mat2 thresh2] = s02_Thresh(temp,'single','useless',Thr(ll+1), MakeBinar, Fisc);end%Binarize matrix
            
            if exist('fmst'),if fmst & strcmp(MakeBinar,'no'),
                mat = mat - ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
                if ll < length(Thr), mat2 = mat2 - ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);end
            end;end;
            
            %Find non zero entries of mat in order to do the proportion of intra community connections.
            [ridx cidx] = find(mat > 0); 
            [ridx2 cidx2] = find(mat2 > 0); 
        
            %Loop for repetedly measuring modularity since it varies from
            %trial to trial.
            clear Ci; clear Q; clear NN; clear Prop; clear Prev;
            Ci = zeros(xx,xx,nRep);
            for mm = 1:nRep,         
                %if strcmp('yes', MakeBinar),            %Verify whether it is binary or weighted measure
                    [tCi tQ]=modularity_louvain_und(mat);
                    
                    if ~exist('NN'),NN = 0; Prop = 0;Prev = 0; Q = zeros(size(tQ));end
                    
                    Cridx = tCi(ridx);Ccidx = tCi(cidx);
                    tProp = (sum((Cridx - Ccidx) == 0)/2) / round( (length(tCi) - 1).*(length(tCi)/2).*Thr(ll) );
                    
                    NN = NN + max(tCi); Prop = Prop + tProp; Q = Q + tQ;
                    
                    if ll < length(Thr),
                        Cridx2 = tCi(ridx2);Ccidx2 = tCi(cidx2);
                        tPrev = (sum((Cridx2 - Ccidx2) == 0)/2) / round( (length(tCi) - 1).*(length(tCi)/2).*Thr(ll+1) );
                        Prev = Prev + tPrev;
                    end
                    
                    %Create net adjacency matrix
                    for tc = 1:length(unique(tCi)),
                        cLoc = find(tCi == tc);
                        Ci(cLoc,cLoc,mm) = 1;
                    end
                %else
                %    [tCi tQ]=modularity_louvain_und(mat);
                %    
                %    if ~exist('NN'),NN = 0; Prop = 0;Prev = 0; Q = zeros(size(tQ));end
                %    
                %    Cridx = tCi(ridx);Ccidx = tCi(cidx);
                %    tProp = (sum((Cridx - Ccidx) == 0)/2) / round( (length(tCi) - 1).*(length(tCi)/2).*Thr(ll) );
                %    
                %    NN = NN + max(tCi); Prop = Prop + tProp; Q = Q + tQ;
                %    
                %    if ll < length(Thr),
                %        Cridx2 = tCi(ridx2);Ccidx2 = tCi(cidx2);
                %        tPrev = (sum((Cridx2 - Ccidx2) == 0)/2) / round( (length(tCi) - 1).*(length(tCi)/2).*Thr(ll+1) );
                %        Prev = Prev + tPrev;
                %    end
                    
                    %%%%%
                %end
            end
             
            %Get the average of Ci and Q
            Q = Q./nRep;
            NN = NN./nRep;
            Prop = Prop./nRep;
            Prev = Prev./nRep;
            Ci = sum(Ci,3)/nRep;
            
            %Put measure in result mat
            Modularity.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = Q;
            Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,:,kk) = Ci;
            NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = NN;
            PropIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = Prop;
            if ll < length(Thr),
                PrevIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = Prev;
            end
            
            
        end
         
        Modularity.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(Modularity.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        Modularity.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(Modularity.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
        Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
        NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
        PropIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(PropIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        PropIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(PropIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
        if ll < length(Thr),
            PrevIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(PrevIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
            PrevIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(PrevIntra.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        end
      end
   end
end
end

if sMod == 1, save(strcat(OutP,'Modularity.mat'),'Modularity');end
if sCom == 1, save(strcat(OutP,'Community.mat'),'Community');end
if sNet == 1, save(strcat(OutP,'NNet.mat'),'NNet');end
if sProp == 1, save(strcat(OutP,'PropIntra.mat'),'PropIntra');end
if sPrev == 1, save(strcat(OutP,'PrevIntra.mat'),'PrevIntra');end