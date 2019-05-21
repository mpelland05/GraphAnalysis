%Launch_AverageDiCeAcrossScales
files_in.string = '_scf';

%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/avg_OutputCmpTopo.mat';
AverageDiCeAcrossScales(files_in);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/avg_OutputCmpTopo.mat';
AverageDiCeAcrossScales(files_in);



%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/avg_OutputCmpTopo.mat';
AverageDiCeAcrossScales(files_in);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/avg_OutputCmpTopo.mat';
AverageDiCeAcrossScales(files_in);

