AnalName = 'Efficiency_global';%Name of analysis

if exist(strcat( OutP,'Efficiency_glob.mat' )) == 2,
    load(strcat( OutP,'Efficiency_glob.mat' ));
end

for ee = 1:length(ext),
for cc = 1:length(Cond),
   for gg = 1:length(Groups),
      [xx yy numPart] = size(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee}));%get num of participants
      
      for ll = 1:length(Thr),
          
        %Create result mat
        Efficiency_glob.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(1,numPart);
          
        for kk = 1:numPart,
            temp =  ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee})(:,:,kk);
             
            %Get measure
            [mat thresh] = s02_Thresh(temp,'single','useless',Thr(ll), MakeBinar, Fisc); %Binarize matrix
            
            %Verify whether it is binary or weighted measure
            if strcmp('yes', MakeBinar),
                res = efficiency_bin(mat);
            else
                res = efficiency_wei(mat);
            end
             
            %Put measure in result mat
            Efficiency_glob.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = res;
            
            %use niak_fdr on vector of p value to obtain corrected p-values
            %such as: [fdr,test] = niak_fdr(p,'LSL',q/2);
            
            
        end
         
        Efficiency_glob.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(Efficiency_glob.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        Efficiency_glob.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(Efficiency_glob.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
      end
   end
end
end

save(strcat(OutP,'Efficiency_glob.mat'),'Efficiency_glob');