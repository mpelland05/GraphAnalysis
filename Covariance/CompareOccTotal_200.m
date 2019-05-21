%This script will take the full connectome and a smaller connectome and
%compare which regions are kept with different thresholding. This is done
%by calculating the dice score

%Generate path to the folder containing the graph analysis scripts
addpath(genpath('F:\GraphAnalysis\scripts\Specific'));

files_in.Conn = 'F:\GraphAnalysis\raw\200\CompiledConnectivityMatrices_8Net.mat' ;%Full path to .mat file containing the whole connectome of participants

files_out = 'F:\GraphAnalysis\scripts\The_parts.mat';

xls_out = 'F:\GraphAnalysis\scripts\The_parts.xls';
xls_col = {'C' 'D' 'E' 'F'};
xls_row = {'2' '16' '26'};

load(files_in.Conn);

parts = fieldnames(ConnMatrix.Net_index);
cond = fieldnames(ConnMatrix); cond = cond([1 2]);
groups = fieldnames(ConnMatrix.(cond{1}));
tresh = [.05:.05:.2];

for gg = 1:length(groups),
    for cc = 1:length(cond),
        
        %Find number of participant of this groups
        [xx yy nSub] = size( ConnMatrix.(cond{cc}).(groups{gg}).mat ); 
        
        for tt = 1:length(tresh),         
            for papa = 1:length(parts), 
                
                %Create result matrix
                Results.(cond{cc}).(groups{gg}).(parts{papa}).(strcat('thresh_', num2str(tresh(tt).*100))) = zeros(nSub,1);
                
                for pp = 1:nSub,
                    
                    %Find the number of the networks that make this "part"
                    tidx = ConnMatrix.Net_index.(parts{papa});
                    
                    %Threshold the whole conn matrix of participant
                    tmat = threshold_proportional(squeeze(ConnMatrix.(cond{cc}).(groups{gg}).mat(:,:,pp)), tresh(tt));
                    tmat = tmat(tidx,tidx); tmat = find(tmat ~=0);
                    
                    %Threshold the part of the participant
                    tpmat = threshold_proportional(squeeze(ConnMatrix.(cond{cc}).(groups{gg}).mat(tidx,tidx,pp)), tresh(tt));
                    tpmat = find(tpmat ~=0);
                    
                    pOver = ( 2.*length(intersect(tpmat,tmat)) ) / ( length(tmat) + length(tpmat) );     
                    
                    Results.(cond{cc}).(groups{gg}).(parts{papa}).(strcat('thresh_', num2str(tresh(tt).*100)))(pp) = pOver;
                    
                end
                
                xlswrite(xls_out,Results.(cond{cc}).(groups{gg}).(parts{papa}).(strcat('thresh_', num2str(tresh(tt).*100))), ...
                        parts{papa}, strcat(xls_col{tt},xls_row{gg}) );
                
            end
        end
    end
end

save(files_out,'Results')