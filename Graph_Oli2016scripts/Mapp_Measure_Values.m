%This script will take the .mat results for varying comparisions of graph
%theory measure and map them unto a brain. 

%SubScales = {'sci202_scg202_scf202'};%{'sci190_scg190_scf190'};
SubScales = {'sci190_scg190_scf190'};%{'sci3_scg3_scf3' 'sci5_scg5_scf5' 'sci13_scg10_scf10' 'sci20_scg22_scf26' 'sci40_scg40_scf40'};

files_in.partition='F:\Modularity\fmri\region_growing_RestOnly_CBSCMixed_OccMask\rois\brain_rois.nii'; %for the 190
%files_in.partition = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\rois\brain_rois.nii'; %for 202

Tests = {'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'SizeComp'};
Groups = {'CB' 'SC'};
Cond = {'rest'};
ext = {'mat'};

for ss = 1:length(SubScales),
    for tt = 1:length(Tests),
        
        %files_in.partition = strcat('F:\Modularity\fmri\basc_RestOnly_CBSCMixed_OccMask_f\stability_group\',SubScales{ss},'\brain_partition_consensus_group_',SubScales{ss},'.nii');
        aa = load(strcat('F:\GraphAnalysis\results\Occ_X_90\Smooth\MST\',SubScales{ss},'\',Tests{tt},'.mat'));
               
        for gg = 1:length(Groups),
            for cc = 1:length(Cond),
                for ee = 1:length(ext),
                    %files_in.partition = strcat('F:\Modularity\fmri\basc_RestOnly_CBSCMixed_OccMask_f\stability_group\',SubScales{ss},'\brain_partition_consensus_group_',SubScales{ss},'.nii');
                    aa = load(strcat('F:\GraphAnalysis\results\Occ_X_90\Smooth\MST\',SubScales{ss},'\',Tests{tt},'.mat'));
    
                    Thr_list = fieldnames(aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}));
                    
                    temp = aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}).(Thr_list{1}).mat;
                    for th = 2:length(Thr_list),
                        temp = cat(3,temp,aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}).(Thr_list{th}).mat);
                    end
                    
                    mm = mean(temp,3);mm = mean(mm,2);files_in.data = mm;
    
                    num = SubScales{ss}(( strfind(SubScales{ss},'scf') + 3):end);
        
                    files_out = strcat('F:\GraphAnalysis\results\Occ_X_90\Smooth\MST\',SubScales{ss},'\',Tests{tt},'_',Groups{gg},'_',num,'_Values.nii');
    
                    Export2Volume(files_in,files_out);
                end
            end
        end
    end
end