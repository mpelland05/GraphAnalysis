%Launch_AverageDiCeAcrossScales for multiple bootstrap samples (made with previous script: compare topo)
fs = filesep;

nsamps = 1000; %number of samples for the 

opt.scales =  repmat(3:25,3,1);
opt.groups = {'CBxxx','SCxxx'};

pip.opt.psom.path_logs = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_RightLeftLogs/PipeAvgDiceWithinParticipants/';

gpath{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
gpath{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/';

%%%%%%%%%%%%%%%%%%%%
%%% Loop for pipeline creation over samples and scales
%%%%%%%%%%%%%%%%%%%
pipeline = struct();

for kk = 1:nsamps,			%%Loop for bootstrap samples
    for ll = 1:length(gpath), 	%%%%% Loop for different gpaths, Left and Rigth in the original analysis.  

        files_in = strcat( gpath{ll}, 'Samp', num2str(kk),'/OutputCmpTopo.mat' );
 	[pp,nn,ee] = fileparts(files_in);
	files_out = strcat(pp,fs,'avg_',nn,ee);

	pipeline = psom_add_job(pipeline,strcat('AvgTopoPath',num2str(ll),'Samp',num2str(kk)),'AverageDiCeWithinParticipantsPipe',files_in,files_out,opt,0);
    end
end

%%%%%%
% Start pipeline
%%%%%%

psom_run_pipeline(pipeline,pip.opt.psom);