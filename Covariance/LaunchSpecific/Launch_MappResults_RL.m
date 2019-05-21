%This script will take the .mat results for varying comparisions of graph
%theory measure and map them unto a brain. 
addpath('F:\MatlabToolboxes\General_Scripts');

files_in.partition = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Lrois\brain_rois.nii'; %

SubScales = {'sci102_scg102_scf102'};
Tests = {'WithinModDegree', 'ParticipationCoef'};%{'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'SizeComp'};
Mask = 'fdr'; %otions, fdr or p
alpha = 0.1;
sal = num2str(alpha); sal = sal(3:end);

for ss = 1:length(SubScales),
    for tt = 1:length(Tests),
        %files_in.partition = strcat('F:\Modularity\fmri\basc_RestOnly_CBSCMixed_OccMask_f\stability_group\',SubScales{ss},'\brain_partition_consensus_group_',SubScales{ss},'.nii');
        load(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{ss},'\',Tests{tt},'_Main_Effect_tvalue.mat'));
    
        if strcmp(Mask,'fdr'),
            [fdr test] = niak_fdr(Results.pvalue.mat(:),'BH',alpha);
            ssign = zeros(size(test)); ssign(find(Results.tvalue.mat < 0)) = -1;ssign(find(Results.tvalue.mat > 0)) = 1;
            files_in.data = fdr.*test.*ssign;
        else
            test = Results.pvalue.mat < alpha;
            ssign = zeros(size(test)); ssign(find(Results.tvalue.mat < 0)) = -1;ssign(find(Results.tvalue.mat > 0)) = 1;
            files_in.data = Results.pvalue.mat.*test.*ssign;
        end
        
        sum(test);
        
        %files_in.data = Results.tvalue.mat.*test;%map with tvalues
        %map with pvalues
        
        num = SubScales{ss}(( strfind(SubScales{ss},'scf') + 3):end);
        
        mkdir(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{ss},'\',Mask,sal));
        files_out = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\',SubScales{ss},'\',Mask,sal,'\',Tests{tt},'_',num,'_M_tvalue.nii');
    
        Export2Volume(files_in,files_out);
    
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This script will take the .mat results for varying comparisions of graph
%theory measure and map them unto a brain. 
addpath('F:\MatlabToolboxes\General_Scripts');

files_in.partition = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Rrois\brain_rois.nii'; %

SubScales = {'sci111_scg111_scf111'};
Tests = {'WithinModDegree', 'ParticipationCoef'};%{'Betweenness' 'Closeness' 'Clustering' 'Degrees' 'Efficiency' 'SizeComp'};
%Mask = 'p'; %otions, fdr or p
%alpha = 0.005;
%sal = num2str(alpha); sal = sal(3:end);

for ss = 1:length(SubScales),
    for tt = 1:length(Tests),
        
        load(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{ss},'\',Tests{tt},'_Main_Effect_tvalue.mat'));
    
        if strcmp(Mask,'fdr'),
            [fdr test] = niak_fdr(Results.pvalue.mat(:),'BH',alpha);
            ssign = zeros(size(test)); ssign(find(Results.tvalue.mat < 0)) = -1;ssign(find(Results.tvalue.mat > 0)) = 1;
            files_in.data = fdr.*test.*ssign;
        else
            test = Results.pvalue.mat < alpha;
            ssign = zeros(size(test)); ssign(find(Results.tvalue.mat < 0)) = -1;ssign(find(Results.tvalue.mat > 0)) = 1;
            files_in.data = Results.pvalue.mat.*test.*ssign;
        end
        
        sum(test);
        
        %files_in.data = Results.tvalue.mat.*test;%map with tvalues
        %map with pvalues
        
        num = SubScales{ss}(( strfind(SubScales{ss},'scf') + 3):end);
        
        mkdir(strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{ss},'\',Mask,sal));
        files_out = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\',SubScales{ss},'\',Mask,sal,'\',Tests{tt},'_',num,'_M_tvalue.nii');
    
        Export2Volume(files_in,files_out);
    
    end
end