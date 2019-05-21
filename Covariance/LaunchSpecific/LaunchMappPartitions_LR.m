addpath('F:\GraphAnalysis\scripts');

clear all;
fs = filesep;

gPath = 'F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\sci102_scg102_scf102';
files_in.atoms = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Lrois\brain_rois.nii';
files_in.names.CB = {'VDAlCh','VDAnBe','VDBeMe','VDDiCe','VDFrCo','VDLL','VDMaLa','VDMaDu','VDMoBe','VDNaTe','VDSePo','VDSoSa','VDYP','VDYvLa'};
files_in.names.SC = {'VDCJ','VDChJa','VDClDe','VDGeAl','VDJM','VDJeRe','VDJoFr','VDKaFo','VDLALH','VDMaSa','VDNiLe','VDNiMi','VDOL','VDPG','VDSC','VDSG','VDTJ'};

files_in.data = strcat(gPath,fs,'HierClustersInd.mat');
files_out = strcat(gPath,fs,'stability_ind');

MappPartitions(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
fs = filesep;

gPath = 'F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\sci111_scg111_scf111';
files_in.atoms = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Rrois\brain_rois.nii';
files_in.names.CB = {'VDAlCh','VDAnBe','VDBeMe','VDDiCe','VDFrCo','VDLL','VDMaLa','VDMaDu','VDMoBe','VDNaTe','VDSePo','VDSoSa','VDYP','VDYvLa'};
files_in.names.SC = {'VDCJ','VDChJa','VDClDe','VDGeAl','VDJM','VDJeRe','VDJoFr','VDKaFo','VDLALH','VDMaSa','VDNiLe','VDNiMi','VDOL','VDPG','VDSC','VDSG','VDTJ'};

files_in.data = strcat(gPath,fs,'HierClustersInd.mat');
files_out = strcat(gPath,fs,'stability_ind');

%MappPartitions(files_in,files_out);
