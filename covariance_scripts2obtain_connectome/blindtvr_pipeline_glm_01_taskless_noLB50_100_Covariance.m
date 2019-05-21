clear 
Loader_left_Covariance
%%%%%%%%%%%%
%% Tests
%%%%%%%%%%%%
%% Rest %%
    
    % CB
    opt.test.rest_CB.group.select(1).label        = 'SelCB';
    opt.test.rest_CB.group.select(1).values       = 1;
    opt.test.rest_CB.group.contrast.intercept     = 1;
    opt.test.rest_CB.group.contrast.age           = 0;
    opt.test.rest_CB.group.contrast.sex           = 0;
    opt.test.rest_CB.group.contrast.FDrest        = 0;
    opt.test.rest_CB.inter_run.select(1).label    = 'TVR'; 
    opt.test.rest_CB.inter_run.select(1).values   = 0;    
    opt.test.rest_CB.intra_run.type = 'covariance';
        
 
%%%%%%%%%%%%%%%%%%%
%% Run the pipeline
%%%%%%%%%%%%%%%%%%%
opt.flag_test = false; 
[pipeline,opt] = niak_pipeline_glm_connectome_covariance_maxime(files_in,opt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear 

Loader_right_Covariance

%%%%%%%%%%%%
%% Tests
%%%%%%%%%%%%
%% Rest %%
    
    % SC
    opt.test.rest_SC.group.select(1).label        = 'SelSC';
    opt.test.rest_SC.group.select(1).values       = 1;
    opt.test.rest_SC.group.contrast.intercept     = 1;
    opt.test.rest_SC.group.contrast.age           = 0;
    opt.test.rest_SC.group.contrast.sex           = 0;
    opt.test.rest_SC.group.contrast.FDrest        = 0;
    opt.test.rest_SC.inter_run.select(1).label    = 'TVR';
    opt.test.rest_SC.inter_run.select(1).values   = 0;
    opt.test.rest_SC.intra_run.type = 'covariance';
                
 
%%%%%%%%%%%%%%%%%%%
%% Run the pipeline
%%%%%%%%%%%%%%%%%%%
opt.flag_test = false; 
[pipeline,opt] = niak_pipeline_glm_connectome_covariance_maxime(files_in,opt);
