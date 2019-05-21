%This script is written to transfer files containing tseries from BASC in a
%single folder. 

fs = filesep;

Cond = {'rest'};
Groups = {'CBx' 'SCx'};

files_in.path = 'F:\Modularity\fmri\basc_RestOnly_CBSCMixed_OccMask_f2\stability_ind\';
files_in.sub = {'sci50_scf50'};

files_out = 'F:\GraphAnalysis\raw\Occ_Ind50\';


for ss = 1:length(files_in.sub), %%This line is to avoid taking all the folders of the directory

    scale = files_in.sub{ss};
    
    %%%%%%%%
    %find list of folder names using  files_in.path
    %%%%%%%%
    tdir = dir(strcat( files_in.path ));
    tnam = find(vertcat(tdir.isdir) == 1);

    for tt = 1:length(tnam),
        tpnames{tt} = tdir(tnam(tt)).name;
    end

    %Remove . and ..
    tt = find(strcmp(tpnames,'.'));
    if ~isempty(tt),
        tpnames{tt} = [];
    end
    tt = find(strcmp(tpnames,'..'));
    if ~isempty(tt),
        tpnames{tt} = [];
    end
    
    tpnames = tpnames(~cellfun('isempty', tpnames)); 
    pnames = tpnames; clear tpnames;
    
    
    %%%create outfolder
    mkdir(strcat( files_out,files_in.sub{ss} ));
    
    %loop for participants
    for pp = 1:length(pnames),
        tpath = strcat(files_in.path, pnames{pp}, fs, files_in.sub{ss});
        
        %%%%%%%%
        %find list of files names using  files_in.path
        %%%%%%%%
        tdir = dir(tpath);
        tnam = find(vertcat(tdir.isdir) == 0);
    
        for tt = 1:length(tnam),
            tpnames{tt} = tdir(tnam(tt)).name;
        end
        
        %%%%%%% BEWARE!!!!
        %Filter a cell array (keep specified strings)
        %%%%%%%
        tLoc = cellfun('isempty',strfind(tpnames,'tseries')) == 0;
        tpnames = tpnames(find(sum(tLoc,1) > 0));
        
        load(strcat(tpath,fs,tpnames{1}));
        
        %Get name of variable to ressemble that used by glm-connectome
        tgr = find(cellfun('isempty',regexp(tpnames{1},Groups)) == 0);
        tco = find(cellfun('isempty',regexp(tpnames{1},Cond)) == 0);
        
         niak_mat2lvec(corrcoef(tseries));
        
        cline = strcat(Cond{tco},'_',Groups{tgr}(1:2),'.connectome = niak_mat2lvec(corrcoef(tseries));' );
        eval(cline);
        
        %Get modified name for output file
        tn = regexprep(tpnames{1},'tseries_group_consensus_','connectome');tn = regexprep(tn,files_in.sub{ss},'');tn = regexprep(tn,strcat( Cond{tco},'_run' ),files_in.sub{ss});
        
        oname = strcat( files_out,files_in.sub{ss},fs,tn );
        save(oname,strcat(Cond{tco},'_',Groups{tgr}(1:2)))
    end
end