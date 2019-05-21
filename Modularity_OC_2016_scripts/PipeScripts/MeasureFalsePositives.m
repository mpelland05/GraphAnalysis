function MeasureFalsePositives(files_in,files_out,opt)
%% This script will launch a pipe to measure the number of samples in which a false
%% positive is found.
%% Here, the use of pipeline is only useful to automatically create output folders. 
%% Note, correction for negative tests is not fully well impleted for FDR. For Bonf, only positive differences (within > between) are kept. 
%
%files_in	cell of strings, path(s) in in which the samples are found.
%files_out	full path to .mat file, file in which the results will be saved. There should be the same number of paths as files_in
%opt
%	.alpha		double, Pvalue used, e.g.: 0.05.
%	.corrtype 	string, 'bonf' or 'fdr', type of correction to use for multiple comparison
%	.nsamps 	integer, number of samples of the bootstrap
%	.specname 	cell of strings, name of the tests
%	.contrast_name	string, the string does not need to be complete (althought it could help), best match will be found within the fields and used.

%files_in{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/';
%files_in{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/';
%files_out{1} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/ResultsControl/NumberFP.mat';
%files_out{2} = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_control_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/ResultsControl/NumberFP.mat';

fs = filesep;

for ff = 1:length(files_in),
    fi = files_in{ff};
    fo = files_out{ff};
    [pp,nn,ee]=fileparts(fo);
    psom_mkdir(pp);

    
    for ss = 1:length(opt.specname),

	%Find complete name of the contrast
	%To do so, loads file from sample one to get the structure where the data is stored. 
	load( strcat(fi,'Samp1',fs,'Permutated',fs,'Perm_avg_OutputCmpTopo_',opt.specname{ss},'_wAvg_Paired.mat') ); 
	fn = fieldnames(Perm);
	tloc = find(~cellfun('isempty',strfind(fn,opt.contrast_name)));
	contname = fn{tloc};
	

	%Read atoms and squeeze the number of tests-> Does only one test per atom
	%This is only done on the first sample, afterward, the same voxels are used. 
	[hdr Atm] = niak_read_vol(Perm.Atoms);

	Atom = Atm(Perm.VoxelsIdx);clear Atm;
	uAtom = unique(Atom);
	uAtom(find(uAtom == 0)) = [];

  	for uu = 1:length(uAtom),
  	    temp = find( Atom == uAtom(uu) );
   	    Loc(uu) = temp(1);    
	end
	clear Perm;


	% Create output variable
	Results.(contname) = zeros(1,opt.nsamps);
	Histo.(contname) = zeros(length(Loc),opt.nsamps);

	%%%%%%%%%%%%
	% Big sample loop
	%%%%%%%%%%%%%%%%%%
	for ii = 1:opt.nsamps,

	    load( strcat(fi,'Samp',num2str(ii),fs,'Permutated',fs,'Perm_avg_OutputCmpTopo_',opt.specname{ss},'_wAvg_Paired.mat') );

	    %Count number of significant results
	    pce = zeros(length(Perm.(contname).pvalues(Loc)),1 ); 
	    pce(:) = Perm.(contname).pvalues(Loc);

	    if strcmp(opt.corrtype,'fdr'),
	        [fdr, test] = niak_fdr(pce','BH',opt.alpha);
		Results.(contname)(ii) = sum(test);
		Histo.(contname)(:,ii) = test;
	    else
    		Avg = Perm.(contname).Average(Loc);
		pce(find(Avg < 0)) = 1; %set negative group differences to a p value of 1... so basically makes then non-significant. 

		Results.(contname)(ii) = sum(pce< (opt.alpha./length(Loc)));
		Histo.(contname)(:,ii) = pce< (opt.alpha./length(Loc));

	    end
	end
    end

   save(fo, 'Results','Histo');
   clear Results;
end
end
