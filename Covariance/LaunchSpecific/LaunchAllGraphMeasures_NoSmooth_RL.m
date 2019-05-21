%This script will launch various measures of graph analysis 
addpath('F:\GraphAnalysis\scripts\');
addpath('F:\GraphAnalysis\scripts\Specific');


%%%%%%%
% Subs
%%%%%%%
SubScales = {'sci102_scg102_scf102'};
gPath = 'F:\GraphAnalysis\raw\Occ_X_90\Occ200_NoSmooth_RL\NormalizeTseries_L\';
gOut = 'F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Left\';
AtmPath = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Lrois\brain_rois.nii';

%%%%%%%
% Options
%%%%%%%
fmst = 1;%Wheter to use a fully connected connectome or not. Mostly important for betweeness and, most of all, modularity

Fisc = 'no';
MakeBinar = 'no';
gamma_crit = [1.3 1.7 2];
Cond = {'rest'};
Groups = {'CB','SC'};
%ThrAll = repmat(.05:.05:.5,length(SubScales),1); %Use this line if you want to use the same (p) threshold throughout all scales. Not that some scales do not have enought connections to allow this to be done with a fully connected connectome
ThrAll = {[.05:.05:.5]};%{[.2:.05:.5] [.15:.05:.5] [.1:.05:.5] [.05:.05:.5] [.05:.05:.5] [.05:.05:.5] [.05:.05:.5]};

nSamps = 1000; %Number of samples for "basc"

%%%%%
% Special options for modularity
%%%%%%
nRep = 100; %Number of repetitions for the modularity algorithm
sMod = 1;
sCom = 1;
sNet = 1;
sProp = 1;
sPrev = 1;
sComp = 1;
sSize = 1;
sShort = 1;

%%%%%%%
% Ext
%%%%%%%
ext{1} = 'mat'; %use if you did not subdivide the connectome
%ext = {'Occ' 'Cerebellum' 'DMN' 'Auditory' 'Thalamus' 'Sensorimotor' 'Temporal_ventroFrontal' 'Fronto_Parietal'};



%%%%%%%
% Loop
%%%%%%%
for susu = 1:length(SubScales),
    
    Thr = ThrAll{susu};
    
    BaseP = strcat(gPath,SubScales{susu},'\');
    OutP = strcat(gOut,SubScales{susu},'\');
    mkdir(OutP);
    
    load(strcat(BaseP,'CompiledConnectivityMatrices.mat'));

    %if strcmp(ext{1}, 'See_Next'),
    %    for gu = 1:length(Groups),
    %        for cu = 1:length(Cond),
    %            ConnMatrix.(Cond{cu}).(Groups{gu}).(ext{1}).mat = ConnMatrix.(Cond{cu}).(Groups{gu}).mat;
    %        end
    %    end
    %end
    
    %Comp_Components;
    %Comp_Modularity_IntraConn;
    %Comp_Modularity_Gamma;
    %Comp_Betweenness;
    %Comp_Clustering;
    %Comp_Degree;
    %Comp_Efficiency;
    %Comp_Closeness;
    %Comp_Efficiency_glob;
    %Comp_HierClustersInd;
    %Comp_HierClustersGroup;
    Comp_WithinModDegree
    Comp_ParticipationCoef
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all


%This script will launch various measures of graph analysis 
addpath('F:\GraphAnalysis\scripts\');
addpath('F:\GraphAnalysis\scripts\Specific');
AtmPath = 'F:\Modularity\fmri\region_growing_01_RestOnly_NoSmooth\Rrois\brain_rois.nii';

%%%%%%%
% Subs
%%%%%%%
SubScales = {'sci111_scg111_scf111'};
gPath = 'F:\GraphAnalysis\raw\Occ_X_90\Occ200_NoSmooth_RL\NormalizeTseries_R\';
gOut = 'F:\GraphAnalysis\results\Occ_X_90\NoSmooth\Mst_RL\Right\';

%%%%%%%
% Options
%%%%%%%
fmst = 1;%Wheter to use a fully connected connectome or not. Mostly important for betweeness and, most of all, modularity
nSamps = 1000;

Fisc = 'no';
MakeBinar = 'no';
gamma_crit = [1.3 1.7 2];
Cond = {'rest'};
Groups = {'CB','SC'};
%ThrAll = repmat(.05:.05:.5,length(SubScales),1); %Use this line if you want to use the same (p) threshold throughout all scales. Not that some scales do not have enought connections to allow this to be done with a fully connected connectome
ThrAll = {[.05:.05:.5]};%{[.2:.05:.5] [.15:.05:.5] [.1:.05:.5] [.05:.05:.5] [.05:.05:.5] [.05:.05:.5] [.05:.05:.5]};


%%%%%
% Special options for modularity
%%%%%%
nRep = 100; %Number of repetitions for the modularity algorithm
sMod = 1;
sCom = 1;
sNet = 1;
sProp = 1;
sPrev = 1;
sComp = 1;
sSize = 1;
sShort = 1;

%%%%%%%
% Ext
%%%%%%%
ext{1} = 'mat'; %use if you did not subdivide the connectome
%ext = {'Occ' 'Cerebellum' 'DMN' 'Auditory' 'Thalamus' 'Sensorimotor' 'Temporal_ventroFrontal' 'Fronto_Parietal'};



%%%%%%%
% Loop
%%%%%%%
for susu = 1:length(SubScales),
    
    Thr = ThrAll{susu};
    
    BaseP = strcat(gPath,SubScales{susu},'\');
    OutP = strcat(gOut,SubScales{susu},'\');
    mkdir(OutP);
    
    load(strcat(BaseP,'CompiledConnectivityMatrices.mat'));

    %if strcmp(ext{1}, 'See_Next'),
    %    for gu = 1:length(Groups),
    %        for cu = 1:length(Cond),
    %            ConnMatrix.(Cond{cu}).(Groups{gu}).(ext{1}).mat = ConnMatrix.(Cond{cu}).(Groups{gu}).mat;
    %        end
    %    end
    %end
    
    %Comp_Components;
    %Comp_Modularity_IntraConn;
    %Comp_Modularity_Gamma;
    %Comp_Betweenness;
    %Comp_Clustering;
    %Comp_Degree;
    %Comp_Efficiency;
    %Comp_Closeness;
    %Comp_Efficiency_glob;
    %Comp_HierClustersInd;
    %Comp_HierClustersGroup;
    Comp_WithinModDegree
    Comp_ParticipationCoef
end

