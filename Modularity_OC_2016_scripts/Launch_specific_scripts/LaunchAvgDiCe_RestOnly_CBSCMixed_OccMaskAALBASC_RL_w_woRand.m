files_in.scales =  repmat(3:25,3,1);
files_in.groups = {'CBxxx','SCxxx'};

%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Right/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAALBASC_Left/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)

%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Right/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)

%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskAAL_Left/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)



%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Right/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAALBASC_Left/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)

%%%%%%%%%%%%%%%%%%%%%% Right long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Right/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)

%%%%%%%%%%%%%%%%%%%%%% Left long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskAAL_Left/OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
files_out = strcat( files_in.path(1:lsep(end)) , 'avg_' , files_in.path(lsep(end)+1:end) );

AverageDiCe(files_in,files_out)