AnalName = 'Clustering';%Name of analysis

BaseP = 'F:\Connectivity\GraphTheory\gMaxAnalysis\Partials\';
State = {'Rest', 'Task'};
Groups = {'CB', 'SC'};
Thr = [.05 .1 .2 .3 .4 .49];

load(strcat(BaseP,'CompiledConnectivityMatrices_partials.mat'));


for ii = 1:length(State),
   for jj = 1:length(Groups),
      [xx yy numPart] = size(ConnMatrix.(State{ii}).(Groups{jj}).mat);%get num of participants
      
      for ll = 1:length(Thr),
          
        %Create result mat
        Clustering.(State{ii}).(Groups{jj}).(strcat('thr_',num2str(Thr(ll)*100))).mat = zeros(xx,numPart);
          
        for kk = 1:numPart,
            temp =  ConnMatrix.(State{ii}).(Groups{jj}).mat(:,:,kk);
             
            %Get measure
            [mat thresh] = s02_Thresh(temp,'single','useless',Thr(ll), 'yes'); %Binarize matrix
            res = clustering_coef_bu(mat);
             
            %Put measure in result mat
            Clustering.(State{ii}).(Groups{jj}).(strcat('thr_',num2str(Thr(ll)*100))).mat(:,kk) = res;
            
            %use niak_fdr on vector of p value to obtain corrected p-values
            %such as: [fdr,test] = niak_fdr(p,'LSL',q/2);
            
            
        end
         
        Clustering.(State{ii}).(Groups{jj}).(strcat('thr_',num2str(Thr(ll)*100))).Avg = mean(Clustering.(State{ii}).(Groups{jj}).(strcat('thr_',num2str(Thr(ll)*100))).mat,2);
        Clustering.(State{ii}).(Groups{jj}).(strcat('thr_',num2str(Thr(ll)*100))).Std = std(Clustering.(State{ii}).(Groups{jj}).(strcat('thr_',num2str(Thr(ll)*100))).mat,1,2);
        
      end
   end
end

save(strcat(BaseP,'Clustering_partials.mat'),'Clustering');