AnalName = 'Within module degree'%Name of analysis

%This script will take the partition scheme of each participant, and from
%it, calculate the within module degree of it. 


if exist(strcat( OutP,'WithinModDegree.mat' )) == 2,
    load(strcat( OutP,'WithinModDegree.mat' ));
end

load(strcat( OutP,'HierClustersInd.mat' ));


for ee = 1:length(ext),
for cc = 1:length(Cond),
    for gg = 1:length(Groups),
      for ll = 1:length(Thr),
          
          %Get number of participants
          [xx yy numPart] = size(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee}));%get num of participants
          
          %Create result mat
          WithinModDegree.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(xx,numPart);
          
          
          for kk = 1:numPart,
          
              %Find community structure
              Ci = sum(eye(xx).* squeeze( HierClustersInd.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,:,kk) ));
          
              %Get connectivity matrix for participants
              temp =  ConnMatrix.(Cond{cc}).(Groups{gg}).(ext{ee})(:,:,kk);
            
                if exist('fmst'),if fmst & strcmp(MakeBinar,'no'),
                    temp = temp + ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
                end;end;

            %threshold the matrix
            [mat thresh] = s02_Thresh(temp,'single','useless',Thr(ll), MakeBinar, Fisc); %Binarize matrix
            
            %Get connmat without the mst
                if exist('fmst'),if fmst & strcmp(MakeBinar,'no'),
                    mat = mat - ConnMatrix.(Cond{cc}).(Groups{gg}).(strcat( ext{ee},'_tree' ))(:,:,kk);
                end;end;
              
            %Get the measure
            ZZ = module_degree_zscore(mat,Ci(:)',0);
                    
            %Put measure in result mat
            WithinModDegree.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = ZZ;
            
          end
          
        WithinModDegree.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(WithinModDegree.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        WithinModDegree.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(WithinModDegree.(Cond{cc}).(Groups{gg}).(ext{ee}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
      end
    end
end
end

save(strcat(OutP,'WithinModDegree.mat'),'WithinModDegree');