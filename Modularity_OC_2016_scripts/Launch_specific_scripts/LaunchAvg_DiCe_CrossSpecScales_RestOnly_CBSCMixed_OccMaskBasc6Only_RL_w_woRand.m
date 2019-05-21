%Launch_AverageDiCeAcrossScales
nSpec = 3;%number of scale types
SpecNam = {'Low' 'Mid' 'High'};%Name to give to specific groupings

slist{1} = 3:9;
slist{2} = 10:17;
slist{3} = 18:25;



for ii = 1:nSpec,
files_out = SpecNam{ii}

	for jj = 1:length(slist{ii}),
		nustr = num2str(slist{ii}(jj));
		files_in.scales{jj} = strcat('sci',nustr,'_scf',nustr);
	end

files_in.scales

%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/avg_OutputCmpTopo.mat';
AverageDiCeAcrossSpecificScales(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/avg_OutputCmpTopo.mat';
AverageDiCeAcrossSpecificScales(files_in,files_out);



%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/avg_OutputCmpTopo.mat';
AverageDiCeAcrossSpecificScales(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.file = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/avg_OutputCmpTopo.mat';
AverageDiCeAcrossSpecificScales(files_in,files_out);


end