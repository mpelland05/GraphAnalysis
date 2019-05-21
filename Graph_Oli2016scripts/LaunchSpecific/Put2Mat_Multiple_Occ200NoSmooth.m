bPath = 'F:\GraphAnalysis\raw\Occ_X_90\Occ200_S_NoSmooth\';

files_in.sub = {'sci202_scg202_scf202'};
Cond = {'rest'};
Groups = {'CB', 'SC'};

for ss = 1:length(files_in.sub),
    BaseP = strcat(bPath,files_in.sub{ss},filesep);
    mSize = str2num(files_in.sub{ss}(strfind(files_in.sub{ss},'f')+1:end));
    
for ii = 1:length(Cond),
    for jj = 1:length(Groups),
        
        files = dir(BaseP);
    
        for kk = 1:length(files),
            idx(kk) = ~isempty(strfind(files(kk).name,[Groups{jj},'x']));
        end
        loc = find(idx == 1);
        
        ConnMatrix.(Cond{ii}).(Groups{jj}).mat = zeros(mSize,mSize,sum(idx));
        
        for kk = 1:length(loc),
            fName = strcat(BaseP,filesep,files(loc(kk)).name);
            vName = strcat(Cond{ii},'_',Groups{jj});
            temp = load(fName,vName);
            ConnMatrix.(Cond{ii}).(Groups{jj}).mat(:,:,kk) = niak_lvec2mat(temp.(vName).connectome);
        end
        clear idx;
    end
end

save(strcat(BaseP,'CompiledConnectivityMatrices.mat'),'ConnMatrix');
end