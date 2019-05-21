fs=filesep;sp=filesep;
files_in.groups = {'SCxxx'};
files_in.scales =  repmat(3:25,3,1);
files_in.numPermutations = 100000;


%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated_SC');    


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated_SC');    


    CompareDiCePaired(files_in,files_out);
end





%%%%%rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated_SC');     


    CompareDiCePaired(files_in,files_out);
end

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.path = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/avg_OutputCmpTopo.mat';
lsep = strfind(files_in.path,filesep);
gPath = files_in.path(1:lsep(end)); 

fname = strcat('Perm_', files_in.path(lsep(end)+1:end-4));

for ii = 1:size(files_in.scales,2),%scales    
   if size(files_in.scales,2) == 1,
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(ii)),'_scf',num2str(files_in.scales(ii)))
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    else
        files_in.ScaleStr = strcat('sci',num2str(files_in.scales(1,ii)),'_scf',num2str(files_in.scales(3,ii)));
	files_in.ScaleStr
        files_in.contrast_name = strcat('SCvsCB_',files_in.ScaleStr);
    end
      
    files_out = strcat(gPath,'Permutated_SC',sp,fname,files_in.ScaleStr,'_Paired','.mat');
    mkdir(gPath,'Permutated_SC');   


    CompareDiCePaired(files_in,files_out);
end
