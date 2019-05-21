function [MinThresh ThreshFull ThreshInfo] = s02a_ThreshMimimum(ConnMatrix,mSize,ext),
%Find mimimal threshold for groups of data and the Threshold to obtain a
%fully connected matrix (each region has a least one connection surviving
%the test. Also, the threshinfo matrix conatians all the information to
%carry stats on these variables. 

Cond = {'rest'};%{'rest', 'task'};
Groups = {'CB', 'SC'};%{'CB', 'LB', 'SC'};

thresh = 1;
fthresh = 0.01; 

for cc = 1:length(Cond),
    for gg = 1:length(Groups),
        [xx yy zz] = size(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext)); %finds number of participants
        for kk = 1:zz,
            %find threshold for each participants
            thresh = 1;
            [BinConnMat thresh] = s02_Thresh(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext)(:,:,kk),'single','all',thresh, 'no');
            [cc gg kk];
            
            ThreshInfo.(Cond{cc}).(Groups{gg}).NoZeros(kk) = thresh;
            
            
            % threshold for fully connected graph.
            S = false;
            fthresh = 0.01;
            while S == false
                S = isconnected(threshold_proportional(squeeze(ConnMatrix.(Cond{cc}).(Groups{gg}).(ext)(:,:,kk)), fthresh));
                if S == false,
                   fthresh = fthresh + 0.01;
                   [cc gg kk];
                end
            end
            
            ThreshInfo.(Cond{cc}).(Groups{gg}).FullConnected(kk) = fthresh;
            
        end
    end
end

%%Find the minimums/ maximum of MinThresh and ThresFull accross groups and
%%conditions.
MT = 1;
TF = 0;
for cc = 1:length(Cond),
    for gg = 1:length(Groups),
        temp = min(ThreshInfo.(Cond{cc}).(Groups{gg}).NoZeros);
        if temp < MT,
           MT = temp; 
        end
        
        temp = min(ThreshInfo.(Cond{cc}).(Groups{gg}).NoZeros);
        if temp > TF,
           TF = temp; 
        end
    end
end
MinThresh = MT;
ThreshFull = TF;

end