function MappPartitions(files_in,files_out),
%files_in.data   string, full path to a .mat file containing partitions for each
%                   participant
%files_in.atoms  string, full path to volume containing the atoms
%               information
%files_in.names.(groups) cells of strings containing name of each
%                       participant
%files_out      string, path to folder which will contain the results
warning off

fs = filesep;

load(files_in.data);

%Read atoms and get their loc
[hdr, atm] = niak_read_vol(files_in.atoms);
for aa = 1:max(unique(atm)),
   LocAtm{aa} = find(atm == aa); 
end

%Start main loop
cond = fieldnames(HierClustersInd);

for cc = 1:length(cond),
    groups = fieldnames(HierClustersInd.(cond{cc}));
    
    for gg = 1:length(groups),
        ext = fieldnames(HierClustersInd.(cond{cc}).(groups{gg}));
        
        for ee = 1:length(ext),
            fn = fieldnames(HierClustersInd.(cond{cc}).(groups{gg}).(ext{ee}));

            for ff = 1:length(fn),          
                [xx yy nPart] = size(HierClustersInd.(cond{cc}).(groups{gg}).(ext{ee}).(fn{ff}).mat);
                
                for pp = 1:nPart,
                    
                    %GEt to which part all atoms belong
                    temp = HierClustersInd.(cond{cc}).(groups{gg}).(ext{ee}).(fn{ff}).mat(:,:,pp);
                    part = sum(temp.*eye(xx,yy));
                    
                    %Create volumes and replace it
                    vol = zeros(size(atm));
                    for aa = 1:max(unique(atm)),
                        vol(LocAtm{aa}) = part(aa); 
                    end
                    
                    %Create participant folder
                    NewDir1 = strcat(groups{gg},'xxx', files_in.names.(groups{gg}){pp} ,'_',cond{cc},'_run');
                    mkdir(files_out,NewDir1);
                    
                    %Create threshold/size folder
                    tnum = regexprep(fn{ff},'thr_','');
                    NewDir2 = strcat('sci',tnum,'_scf',tnum);
                    mkdir(strcat(files_out,fs,NewDir1),NewDir2);
                    
                    %Save volume
                    fold_out = strcat(files_out,fs,NewDir1,fs,NewDir2,fs);
                    fname = strcat( 'brain_partition_consensus_ind_',groups{gg},'xxx', files_in.names.(groups{gg}){pp} ,'_',cond{cc},'_run_','sci',tnum,'_scf',tnum,'.nii' );
                    hdr.file_name = strcat(fold_out,fname);
                    niak_write_vol(hdr,vol);
                end
                
            end
        end
    end
end

warning on
end