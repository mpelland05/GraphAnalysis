%This script will launch various measures of graph analysis 
addpath('F:\GraphAnalysis\scripts\');
addpath('F:\GraphAnalysis\scripts\Specific');


%%%%%%%
% Subs
%%%%%%%
SubScales = {'sci190_scg190_scf190'};%{'sci11_scg9_scf10' 'sci18_scg17_scf16' 'sci45_scg36_scf34' 'sci70_scg70_scf68' 'sci90_scg108_scf84' 'sci190_scg190_scf190'}; %'sci5_scg4_scf4' 


%%%%%%%
% Options
%%%%%%%
fmst = 0;%Wheter to use a fully connected connectome or not. Mostly important for betweeness and, most of all, modularity

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
sMod = 0;
sCom = 0;
sNet = 0;
sProp = 1;
sPrev = 1;
sComp = 0;
sSize = 0;
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
    
    BaseP = strcat('F:\GraphAnalysis\raw\Occ_X_90\',SubScales{susu},'\');
    OutP = strcat('F:\GraphAnalysis\results\Occ_X_90\NoSmooth\NoMST\',SubScales{susu},'\');
    mkdir(OutP);
    
    load(strcat(BaseP,'CompiledConnectivityMatrices.mat'));

    %if strcmp(ext{1}, 'See_Next'),
    %    for gu = 1:length(Groups),
    %        for cu = 1:length(Cond),
    %            ConnMatrix.(Cond{cu}).(Groups{gu}).(ext{1}).mat = ConnMatrix.(Cond{cu}).(Groups{gu}).mat;
    %        end
    %    end
    %end
    
    Comp_Components;
    %Comp_Modularity_IntraConn;
    %Comp_Modularity_Gamma;
    %Comp_Modularity;
    %Comp_Betweenness;
    %Comp_Clustering;
    %Comp_Degree;
    %Comp_Efficiency;
    %Comp_Closeness;
    %Comp_Efficiency_glob;
end