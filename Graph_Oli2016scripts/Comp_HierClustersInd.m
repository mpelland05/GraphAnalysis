AnalName = 'Individual hierarchical clusters'%Name of analysis

if exist(strcat( OutP,'HierClustersInd.mat' )) == 2,
    load(strcat( OutP,'HierClustersInd.mat' ));
end

%load community and NNet information
load(strcat( OutP,'Community.mat' ));
load(strcat( OutP,'NNet.mat' ));


for ee = 1:length(ext),
for cc = 1:length(Cond),
   for gg = 1:length(Groups),
      for ll = 1:length(Thr),
          
        [xx yy numPart] = size(Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat);%get num of participants 
        
        %Create result mat
        HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(xx,xx,numPart);
          
        for kk = 1:numPart,
            temp =  Community.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,:,kk);
            
            hier = niak_hierarchical_clustering(temp);

            opt.type = 'nb_classes';
            opt.thresh = round( NNet.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) );
             
            part = niak_threshold_hierarchy(hier,opt);

            res = zeros(xx,xx);

	    for tc = 1:length(unique(part)),
               cLoc = find(part == tc);
               res(cLoc,cLoc) = tc;
            end

            %Put measure in result mat
            HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,:,kk) = res;
            
        end
         
        HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,3);
        HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,3);
        
      end
   end
end
end

save(strcat(OutP,'HierClustersInd.mat'),'HierClustersInd');