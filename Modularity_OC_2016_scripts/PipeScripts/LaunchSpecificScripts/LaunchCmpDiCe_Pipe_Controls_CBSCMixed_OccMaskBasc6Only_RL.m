fs=filesep;sp=filesep;

nsamps = 1000; %number of samples for the bootstrap

SpecName = {'L36' 'M512' 'H1825' 'All'};%Name to give to specific groupings

opt.groups = {'CBxxx'};
opt.numPermutations = 100000;

gpath{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
gpath{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/';

pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/PipePermutations/';

pipeline = struct();

%%%%%%%%%%%%%%%
% Main loop!
%%%%%%%%%%%%%%

for ii = 1:length(SpecName),
    opt.scalestr = SpecName{ii};
    opt.contrast_name = strcat('CBvsSC_',opt.scalestr);

    for kk = 1:nsamps,
	for ll = 1:length(gpath),

	    files_in = strcat( gpath{ll}, 'Samp', num2str(kk),fs,'avg_OutputCmpTopo_',SpecName{ii},'_wAvg.mat' );
 	    [pp,nn,ee] = fileparts(files_in);
	    files_out = strcat(pp,fs,'Permutated',fs,'Perm_',nn,'_Paired',ee);
	
	    pipeline = psom_add_job(pipeline,strcat('CmpDiCePath',num2str(ll),'Samp',num2str(kk),'Scales',num2str(ii)),'CompareDiCePairedPipe',files_in,files_out,opt,0);


	end
    end
end



%%%%%%
% Start pipeline
%%%%%%

psom_run_pipeline(pipeline,pip.opt.psom);