%This script will take the .mat results for varying comparisions of graph
%theory measure and map them unto a brain. 
addpath('F:\MatlabToolboxes\General_Scripts');

%files_in.partition ='F:\Modularity\fmri\region_growing_RestOnly_CBSCMixed_OccMask\rois\brain_rois.nii'; %for the 190
files_in.partition = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\rois\brain_rois.nii'; %for 202

SubScales = {'sci202_scg202_scf202'};%{'sci190_scg190_scf190'};% %{'sci3_scg3_scf3' 'sci5_scg5_scf5' 'sci13_scg10_scf10' 'sci20_scg22_scf26' 'sci40_scg40_scf40'};
Tests = {'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'SizeComp'};
Mask = 'p'; %otions, fdr or p
alpha = 0.005;

for ss = 1:length(SubScales),
    for tt = 1:length(Tests),
        %files_in.partition = strcat('F:\Modularity\fmri\basc_RestOnly_CBSCMixed_OccMask_f\stability_group\',SubScales{ss},'\brain_partition_consensus_group_',SubScales{ss},'.nii');
        load(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\MST\',SubScales{ss},'\',Tests{tt},'_Main_Effect_tvalue.mat'));
    
        if strcmp(Mask,'fdr'),
            [fdr test] = niak_fdr(Results.pvalue.mat(:),'BH',alpha);
        else
            test = Results.pvalue.mat < alpha;
        end
        
        sum(test);
        
        files_in.data = Results.tvalue.mat.*test;
    
        num = SubScales{ss}(( strfind(SubScales{ss},'scf') + 3):end);
        
        files_out = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\MST\',SubScales{ss},'\',Tests{tt},'_',num,'_M_tvalue.nii');
    
        Export2Volume(files_in,files_out);
    
    end
end
