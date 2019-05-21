BaseP= 'F:\MyStudies\GraphAnalysis\Graph_Oli2016\fmri\Whole_left\';


Cond = {'rest'};
Groups = {'CB', 'SC'};
mSize = 576;

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
            temp = load(fName,'tseries');
            ConnMatrix.(Cond{ii}).(Groups{jj}).mat(:,:,kk) = corrcoef(temp.tseries);
        end
        clear idx;
    end
end

save(strcat(BaseP,'CompiledConnectivityMatrices.mat'),'ConnMatrix');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all


BaseP= 'F:\MyStudies\GraphAnalysis\Graph_Oli2016\fmri\Whole_right\';

Cond = {'rest'};
Groups = {'CB', 'SC'};
mSize = 568;
    
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
            temp = load(fName,'tseries');
            ConnMatrix.(Cond{ii}).(Groups{jj}).mat(:,:,kk) = corrcoef(temp.tseries);
        end
        clear idx;
    end
end

save(strcat(BaseP,'CompiledConnectivityMatrices.mat'),'ConnMatrix');
