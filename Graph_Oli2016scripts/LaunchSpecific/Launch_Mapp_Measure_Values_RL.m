%This script will take the .mat results for varying comparisions of graph
%theory measure and map them unto a brain. 

SubScales = {'sci102_scg102_scf102'};

files_in.partition = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Lrois\brain_rois.nii'; %

Tests = {'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'SizeComp'};
Groups = {'CB' 'SC'};
Cond = {'rest'};
ext = {'mat'};

for ss = 1:length(SubScales),
    for tt = 1:length(Tests),               
        for gg = 1:length(Groups),
            for cc = 1:length(Cond),
                for ee = 1:length(ext),
                    
                    aa = load(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{ss},'\',Tests{tt},'.mat'));
    
                    Thr_list = fieldnames(aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}));
                    
                    temp = aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}).(Thr_list{1}).mat;
                    for th = 2:length(Thr_list),
                        temp = cat(3,temp,aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}).(Thr_list{th}).mat);
                    end
                    
                    mm = mean(temp,3);mm = mean(mm,2);files_in.data = mm;
    
                    num = SubScales{ss}(( strfind(SubScales{ss},'scf') + 3):end);
                    
                    mkdir(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{ss},'\Measures' ));
                    files_out = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{ss},'\Measures\',Tests{tt},'_',Groups{gg},'_',num,'_Values.nii');
    
                    Export2Volume(files_in,files_out);
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SubScales = {'sci111_scg111_scf111'};

files_in.partition = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Rrois\brain_rois.nii'; %

Tests = {'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'SizeComp'};
Groups = {'CB' 'SC'};
Cond = {'rest'};
ext = {'mat'};

for ss = 1:length(SubScales),
    for tt = 1:length(Tests),               
        for gg = 1:length(Groups),
            for cc = 1:length(Cond),
                for ee = 1:length(ext),
                    
                    aa = load(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{ss},'\',Tests{tt},'.mat'));
    
                    Thr_list = fieldnames(aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}));
                    
                    temp = aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}).(Thr_list{1}).mat;
                    for th = 2:length(Thr_list),
                        temp = cat(3,temp,aa.(Tests{tt}).(Cond{cc}).(Groups{gg}).(ext{ee}).(Thr_list{th}).mat);
                    end
                    
                    mm = mean(temp,3);mm = mean(mm,2);files_in.data = mm;
    
                    num = SubScales{ss}(( strfind(SubScales{ss},'scf') + 3):end);
                    
                    mkdir(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{ss},'\Measures' ));
                    files_out = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{ss},'\Measures\',Tests{tt},'_',Groups{gg},'_',num,'_Values.nii');
    
                    Export2Volume(files_in,files_out);
                end
            end
        end
    end
end