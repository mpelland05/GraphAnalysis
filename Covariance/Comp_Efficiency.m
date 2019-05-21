AnalName = 'Efficiency'%Name of analysis

if exist(strcat( OutP,'Efficiency.mat' )) == 2,
    load(strcat( OutP,'Efficiency.mat' ));
end

for ee = 1:length(ext),
for cc = 1:length(Cond),
   for gg = 1:length(Groups),
      [xx yy numPart] = size(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee}));%get num of participants
      
      for ll = 1:length(Thr),
          
        %Create result mat
        Efficiency.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(xx,numPart);
          
        for kk = 1:numPart,
            temp =  ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee})(:,:,kk);
             
            if exist('fmst'),if fmst & strcmp(MakeBinar,'no'),
                temp = temp + ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
            end;end;

            %Get measure
            [mat thresh] = s02_Thresh(temp,'single','useless',Thr(ll), MakeBinar, Fisc); %Binarize matrix
            
            if exist('fmst'),if fmst & strcmp(MakeBinar,'no'),
                mat = mat - ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
            end;end;
        
            %Verify whether it is binary or weighted measure
            if strcmp('yes', MakeBinar),
                res = efficiency_bin(mat,1);
            else
                res = efficiency_wei(mat,1);
            end
             
            %Put measure in result mat
            Efficiency.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = res;
            
            %use niak_fdr on vector of p value to obtain corrected p-values
            %such as: [fdr,test] = niak_fdr(p,'LSL',q/2);
            
            
        end
         
        Efficiency.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(Efficiency.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        Efficiency.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(Efficiency.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
      end
   end
end
end

save(strcat(OutP,'Efficiency.mat'),'Efficiency');