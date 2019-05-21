%Launch_AverageDiCeAcrossScales for multiple bootstrap samples (made with previous script: compare topo)
fs = filesep;

nsamps = 1000; %number of samples for the 

opt.nSpec = 4;
opt.SpecName = {'L36' 'M512' 'H1825' 'All'};	%name of the scales. Will be used to name output file which will be stored in the same folder as the files_in.

slist{1} = 3:6;
slist{2} = 5:12;
slist{3} = 18:25;
slist{4} = 3:25;

pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/PipeAvgDiceAcrossScales/';
pip.opt.psom.mode = 'session';

gpath{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
gpath{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/';

%%%%%%%%%%%%%%%%%%%%
%%% Loop for pipeline creation over samples and scales
%%%%%%%%%%%%%%%%%%%
pipeline = struct();

for ii = 1:opt.nSpec,
    opt.name = opt.SpecName{ii};

    for jj = 1:length(slist{ii}),
	nustr = num2str(slist{ii}(jj));
	opt.scales{jj} = strcat('sci',nustr,'_scf',nustr);
    end

    for kk = 1:nsamps,			%%Loop for bootstrap samples
	for ll = 1:length(gpath), 	%%%%% Loop for different gpaths, Left and Rigth in the original analysis.  

    	    files_in = strcat( gpath{ll}, 'Samp', num2str(kk),'/avg_OutputCmpTopo.mat' );
 	    [pp,nn,ee] = fileparts(files_in);
	    files_out = strcat(pp,fs,nn,'_',opt.name,'_wAvg',ee);

	    pipeline = psom_add_job(pipeline,strcat('AvgTopoPath',num2str(ll),'Samp',num2str(kk),'Scale',num2str(ii)),'AverageDiCeAcrossSpecificScalesPipe',files_in,files_out,opt,0);
	end
    end
end

%%%%%%
% Start pipeline
%%%%%%

psom_run_pipeline(pipeline,pip.opt.psom);