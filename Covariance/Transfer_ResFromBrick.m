%This script is written to transfer files containing tseries from BASC in a
%single folder. 

fs = filesep;

Cond = {'rest'};
Groups = {'CBx' 'SCx'};%{'CBx' 'LBx' 'SCx'};

files_in.path = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\NormalizeTsries_RL\';
files_in.sub = {'NormalizeTseries_L' 'NormalizeTseries_R'};

files_out = 'F:\GraphAnalysis\raw\Occ200_S_NoSmooth_RL\';


for ss = 1:length(files_in.sub), %%This line is to avoid taking all the folders of the directory

    scale = files_in.sub{ss};
    
	%%%%%%%%
	%find list of files names using  files_in.path
	%%%%%%%%
	tdir = dir(strcat(files_in.path,fs,files_in.sub{ss}));
	tnam = find(vertcat(tdir.isdir) == 0);

	for tt = 1:length(tnam),
    		tpnames{tt} = tdir(tnam(tt)).name;
	end
    	for tt = 1:length(tnam),
        	tpnames{tt} = tdir(tnam(tt)).name;
    	end

 
    pnames = tpnames; clear tpnames;
    
    
    %%%create outfolder
    mkdir(strcat( files_out,files_in.sub{ss} ));
    
    %loop for participants
    for pp = 1:length(pnames),
        tpath = strcat(files_in.path, files_in.sub{ss}, fs, pnames{pp});
        
    
        load(tpath);
        
        %Get name of variable to ressemble that used by glm-connectome
        tgr = find(cellfun('isempty',regexp(pnames{pp},Groups)) == 0);
        tco = find(cellfun('isempty',regexp(pnames{pp},Cond)) == 0);
        
         niak_mat2lvec(corrcoef(tseries));
        
        cline = strcat(Cond{tco},'_',Groups{tgr}(1:2),'.connectome = niak_mat2lvec(corrcoef(tseries));' );
        eval(cline);
        
        %Get modified name for output file
        tn = regexprep(pnames{pp},'fmri_','connectome_');tn = regexprep(tn,files_in.sub{ss},'');tn = regexprep(tn,'rest_run_brain_rois','sci190_scg190_scf190');
        
        oname = strcat( files_out,files_in.sub{ss},fs,tn );
        save(oname,strcat(Cond{tco},'_',Groups{tgr}(1:2)))
    end
end
