%LauncMapPQValuesAtomWise.
fs=filesep;

files_in.q = 0.05;%Use of 0.05 since we do both hemispheres (equivalent to 0.1)
files_in.type = 'BH'; %because some tests might be negatively correlated

SpecNam = {'Low' 'Mid' 'High'};%Name to give to specific groupings

for ii = 1:length(SpecNam),
SpecNam{ii}

files_in.scale = SpecNam{ii};
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/104; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/Permutated_SC/Perm_avg_OutputCmpTopo';

files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_',SpecNam{ii},'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/101; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/Permutated_SC/Perm_avg_OutputCmpTopo';

files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_',SpecNam{ii},'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);






%%%%%%%%%%%%
%%% rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/103; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/Permutated_SC/Perm_avg_OutputCmpTopo';

files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_',SpecNam{ii},'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/101; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/Permutated_SC/Perm_avg_OutputCmpTopo';

files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_',SpecNam{ii},'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);

end




%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/104; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Right/Permutated_SC/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;

for ii = 1:size(scales,2),%scales
    
    files_in.scale = strcat('sci',num2str(scales(1,ii)),'_scf',num2str(scales(3,ii)));
    files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
    files_in.path = strcat(gPath,files_in.scale,'_Paired.mat');
    
    %pvalues
    files_out = strcat(gPath,files_in.scale,'_P_Paired')
    MapPValuesAtomWise(files_in,files_out);
    
    %qvalues
    files_out = strcat(gPath,files_in.scale,'_Q_Paired')
    MapQValuesAtomWise(files_in,files_out);
end


files_in.scale = 'AllScales'
files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);


%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/101; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_OccMaskBasc6Only_Left/Permutated_SC/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;

for ii = 1:size(scales,2),%scales
    
    files_in.scale = strcat('sci',num2str(scales(1,ii)),'_scf',num2str(scales(3,ii)));
    files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
    files_in.path = strcat(gPath,files_in.scale,'_Paired.mat');
    
    %pvalues
    files_out = strcat(gPath,files_in.scale,'_P_Paired')
    MapPValuesAtomWise(files_in,files_out);
    
    %qvalues
    files_out = strcat(gPath,files_in.scale,'_Q_Paired')
    MapQValuesAtomWise(files_in,files_out);
end


files_in.scale = 'AllScales'
files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);






%%%%%%%%%%%%
%%% rand
%%%%%%%%%%%%%%%%%%%%%% Right short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/103; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Right/Permutated_SC/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;

for ii = 1:size(scales,2),%scales
    
    files_in.scale = strcat('sci',num2str(scales(1,ii)),'_scf',num2str(scales(3,ii)));
    files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
    files_in.path = strcat(gPath,files_in.scale,'_Paired.mat');
    
    %pvalues
    files_out = strcat(gPath,files_in.scale,'_P_Paired')
    MapPValuesAtomWise(files_in,files_out);
    
    %qvalues
    files_out = strcat(gPath,files_in.scale,'_Q_Paired')
    MapQValuesAtomWise(files_in,files_out);
end


files_in.scale = 'AllScales'
files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);

%%%%%%%%%%%%%%%%%%%%%% Left short %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
files_in.p = 0.025/101; 

gPath = '/home/mpelland/database/Modularity_OC_2016/Results/BASC_RestOnly_CBSCMixed_rand_OccMaskBasc6Only_Left/Permutated_SC/Perm_avg_OutputCmpTopo';
scales = repmat([3:25]',1,3)';

fs=filesep;

for ii = 1:size(scales,2),%scales
    
    files_in.scale = strcat('sci',num2str(scales(1,ii)),'_scf',num2str(scales(3,ii)));
    files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
    files_in.path = strcat(gPath,files_in.scale,'_Paired.mat');
    
    %pvalues
    files_out = strcat(gPath,files_in.scale,'_P_Paired')
    MapPValuesAtomWise(files_in,files_out);
    
    %qvalues
    files_out = strcat(gPath,files_in.scale,'_Q_Paired')
    MapQValuesAtomWise(files_in,files_out);
end


files_in.scale = 'AllScales'
files_in.contrast_name = strcat('SCvsCB_',files_in.scale);
          
files_in.path = strcat(gPath,'_wAvg',files_in.scale,'_Paired_wAvg.mat');
    
%pvalues
files_out = strcat(gPath,files_in.scale,'_P_Paired')
MapPValuesAtomWise(files_in,files_out);

%qvalues
files_out = strcat(gPath,files_in.scale,'_Q_Paired')
MapQValuesAtomWise(files_in,files_out);
