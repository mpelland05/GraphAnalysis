%This script is written to transfer files containing tseries from BASC in a
%single folder. 

fs = filesep;

Cond = {'rest'};
Groups = {'CBx' 'SCx'};
tco = 1;

files_in.path = 'F:\MyStudies\GraphAnalysis\Covariance\Connectomes\';
files_in.sub = {'Whole_Left' 'Whole_Right'};

files_out = 'F:\MyStudies\GraphAnalysis\Covariance\Raw\';


for ss = 1:length(files_in.sub), %%This line is to avoid taking all the folders of the directory

    scale = files_in.sub{ss};
    
    %%%%%%%%
    %find list of folder names using  files_in.path
    %%%%%%%%
    tdir = dir(strcat( files_in.path,scale ));
    tnam = find(vertcat(tdir.isdir) ~= 1);

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
        tpath = strcat(files_in.path, files_in.sub{ss}, fs, pnames{pp});
        
        %%%%%%%%
        %find list of files names using  files_in.path
        %%%%%%%%
        tdir = dir(tpath);
        tnam = find(vertcat(tdir.isdir) == 0);
    
        for tt = 1:length(tnam),
            tpnames{tt} = tdir(tnam(tt)).name;
        end
    
        aa=load(tpath);
        
        %Get name of variable to ressemble that used by glm-connectome
        tgr = find(cellfun('isempty',regexp(tpnames{1},Groups)) == 0);
        %tco = find(cellfun('isempty',regexp(tpnames{1},Cond)) == 0);
	varn = fieldnames(aa);
        
        cline = strcat(Cond{tco},'_',Groups{tgr}(1:2),'.connectome = aa.',varn{1},'.connectome;' );
        eval(cline);
        
        %Get modified name for output file
        tn = regexprep(tpnames{1},'tseries_group_consensus_','connectome');tn = regexprep(tn,files_in.sub{ss},'');tn = regexprep(tn,strcat( Cond{tco},'_run' ),files_in.sub{ss});
        
        oname = strcat( files_out,files_in.sub{ss},fs,tn );
        save(oname,strcat(Cond{tco},'_',Groups{tgr}(1:2)))
    end
end
