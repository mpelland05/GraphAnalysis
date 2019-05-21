AnalName = 'Components numbers'%Name of analysis

addpath('F:\MatlabToolboxes\OtherGraph');
%Please specify sMod, sCom, sNet, sProp and sPrev, sComp, sSize (0 or 1) where 1 will get
%the results of that measure saved.

if exist(strcat( OutP,'SizeComp.mat' )) == 2,load(strcat( OutP,'SizeComp.mat' ));end
if exist(strcat( OutP,'NumComp.mat' )) == 2,load(strcat( OutP,'SizeComp.mat' ));end

for ee = 1:length(ext),
for cc = 1:length(Cond),
   for gg = 1:length(Groups),
      [xx yy numPart] = size(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee}));%get num of participants
      
      for ll = 1:length(Thr),
          
        %Create result mat
        SizeComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(xx,numPart);
        NumComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(1,numPart);
        
        
        for kk = 1:numPart,
            temp =  ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee})(:,:,kk);
            
            if exist('fmst'),if fmst.*strcmp(MakeBinar,'no'),
                temp = temp + ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
            end;end;
            
            %get information of current AND next threshold on current community
            [mat thresh] = s02_Thresh(temp,'single','useless',Thr(ll), MakeBinar, Fisc); %Binarize matrix
            
            if exist('fmst'),if fmst.*strcmp(MakeBinar,'no'),
                mat = mat - ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
            end;end;
            
            %Find number of subgraphs (disconnected from each other) and
            %the size of subgraph to which each atom pertains
            bina = zeros(size(mat));
            bina(find(mat > 0)) = 1;
            [nComp,sizes,members, shortSize] = networkComponents(bina);

            SizeComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = sizes;
            NumComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = nComp;
            
            ShortSize.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat{kk} = shortSize;
        end
         
        SizeComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(SizeComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        SizeComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(SizeComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
                
        NumComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(NumComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        NumComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(NumComp.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);

      end
   end
end
end

if sSize == 1, save(strcat(OutP,'SizeComp.mat'),'SizeComp');end
if sComp == 1, save(strcat(OutP,'NumComp.mat'),'NumComp');end
if sShort == 1, save(strcat(OutP,'ShortSize.mat'),'ShortSize');end