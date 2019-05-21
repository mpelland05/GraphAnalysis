AnalName = 'HierClustersGroup';

load(strcat( OutP,'HierClustersInd.mat' ));

opt.type = 'nb_classes';

for ee = 1:length(ext),
 for cc = 1:length(Cond),
   for gg = 1:length(Groups),
    for ll = 1:length(Thr),
        %find number of participants in each group
        [xx yy nPart] = size(HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat);
        
        temp = zeros(xx,yy,nPart);
        
        for nn = 1:nSamps,
            %Randomly choose participants to be part of sample,
            %participants may be taken twice for a single sample. 
            RandG = round( rand(1,nPart).*(nPart-1) +1);
            
            %Create matrix containing the sample for each group
            mat = HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,:,RandG);

            %Get average number of networks for the sample
            NumNet = [];
            for pp = 1:nPart,
                NumNet = [NumNet (length(unique( mat(:,:,pp) ))-1) ];
            end
            AvgNNet = round(mean(NumNet));
            
            %Get sample hierarchy
            hier = niak_hierarchical_clustering(mean(mat,3));
            
            % Get sample`s parts
            opt.thresh = AvgNNet;%should be the NNet of the participant?
            part = niak_threshold_hierarchy(hier,opt);
            
            %Create matrices from the parts
            for tc = 1:AvgNNet,
                cLoc = find(part == tc);
                temp(cLoc,cLoc,nn) = tc;
            end

        end
        %Get adjacency matrices
        Loc = find(temp > 0);
        temp(Loc) = 1;
        
        %Get hierarchy
        hier = niak_hierarchical_clustering(mean(temp,3));
        
        %Get average number of Nets
        for nn = 1:nPart,
            NNet(nn) = max(unique(mat(:,:,nn)));
        end
        NNet = round(mean(NNet));
        
        %Get parts
        opt.thresh = NNet;
        part = niak_threshold_hierarchy(hier,opt);
        
        %Make volume
        [hdr, atm] = niak_read_vol(AtmPath);
        vol = zeros(size(atm));
        for aa = 1:max(unique(atm)),
            Loc = find(atm == aa);
            vol(Loc) = part(aa);
        end
        
        hdr.file_name = strcat(OutP, 'GroupConsensus_',Cond{cc},'_',Groups{gg},'_',num2str(Thr(ll).*100),'.nii');
        niak_write_vol(hdr,vol);
        clear atm;clear vol;
        
    end
   end
 end
end