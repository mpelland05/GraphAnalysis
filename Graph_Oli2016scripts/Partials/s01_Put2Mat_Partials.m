BaseP = 'F:\Connectivity\GraphTheory\gMaxAnalysis\Partials\';
SecoP = {'Rest', 'Task'};
Groups = {'CB', 'LB', 'SC'};
mSize = 100;%Size of matrix

for ii = 1:length(SecoP),
    files = dir(strcat(BaseP,SecoP{ii},filesep,'Original'));
    
    for jj = 1:length(Groups),
        for kk = 1:length(files),
            idx(kk) = ~isempty(strfind(files(kk).name,[Groups{jj},'x']));
        end
        loc = find(idx == 1);
        
        ConnMatrix.(SecoP{ii}).(Groups{jj}).mat = zeros(mSize,mSize,sum(idx));
        
        for kk = 1:length(loc),
            load(strcat(BaseP,SecoP{ii},filesep,'Original',filesep,files(loc(kk)).name));
            
            %files(loc(kk)).name
            
            ConnMatrix.(SecoP{ii}).(Groups{jj}).mat(:,:,kk) = SquareAnArray(conn,mSize);
        end
        clear idx;
    end
end



save(strcat(BaseP,'CompiledConnectivityMatrices_partials.mat'),'ConnMatrix');