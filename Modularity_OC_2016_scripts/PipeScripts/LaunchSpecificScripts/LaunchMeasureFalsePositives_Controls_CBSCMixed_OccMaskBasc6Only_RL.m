fs = filesep;

files_in{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
files_in{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/';
files_out{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/ResultsControl/NumberFP.mat';
files_out{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/ResultsControl/NumberFP.mat';

opt.alpha = 0.025;
opt.corrtype = 'bonf';
opt.nsamps = 1000; %number of samples for the bootstrap that was done
opt.specname = {'L36' 'M512' 'H1825' 'All'};	%name of the scales. Will be used to name output file which will be stored in the same folder as the files_in.
opt.contrast_name = 'CBvsSC';

MeasureFalsePositives(files_in,files_out,opt)