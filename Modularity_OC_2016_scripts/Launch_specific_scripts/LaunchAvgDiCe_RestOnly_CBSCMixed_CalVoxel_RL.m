files_in.scales =  repmat(2:6,3,1);
files_in.groups = {'CBxxx','SCxxx'};

%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Right/OutputCmpTopo.mat;
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_CalcVoxel_Left/OutputCmpTopo.mat;
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)

