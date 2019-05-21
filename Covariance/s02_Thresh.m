function [BinConnMat thresh] = s02_Thresh(mat,gg,seed,thresh,bin,fisc),
%gg: string taking the value: 'group' or 'single'
%sign: string taking value 'pos' or 'all'
%seed: string taking value 'single' or 'all' which determines whether the
%threshold is applied to the whole matrix or rowwise (so for eah seeds.
%threshold: 0.1 single value containing proportion of seeds to keep for the analysis
%bin: binarize the data, string taking values 'yes' or 'no'
%fisc: apply fischer, yes or no

%s02_Thresh(mat,'single','yo',.001, 'yes')

%Remove negative values
    loc = find(mat < 0);%put negative sign to zero
    if ~isempty(loc),
        mat(loc) = 0;
    end
    
%makes sure that diagonal is zero
[xx yy zz] = size(mat);
for ii = 1:zz,
    mat(:,:,ii) = mat(:,:,ii).*(ones(xx)-eye(xx));
end

%Finding thresholded map
if strcmp(gg,'group'),
    %Group analysis
    
else
    %Single subject analysis
    
    %Find out whether the threshold is too low or not, if too low, set it
    %to minimum permissable. That is, the number of connections that are >
    %zero
    cMax = floor(thresh.*((xx*xx-1)/2)); 
    nConn = sum(sum(triu(mat)>0));
    
    if nConn < cMax,
       thresh = nConn/((xx*xx-1)/2);
       strcat('Threshold was so low that zero correlations were included, threshold was modified to: ',num2str(thresh))
    end
    
    %Get the thresholded matrix
    BinConnMat = threshold_proportional(mat, thresh);
    
    %Binarized the thresholded matrix if needed
    if strcmp(bin,'yes'),
        loc = find(BinConnMat > 0);
        BinConnMat(loc) = 1;
    else
        tem = reshape(BinConnMat,1,[]);
        if strcmp(fisc,'yes') ,tem = ifisherz(tem);end;
        BinConnMat = reshape(tem,size(BinConnMat,1),size(BinConnMat,1));
        if max(max(BinConnMat > 1)), if strcmp(fisc,'yes'),
            'There was an error with keeping the weights, one of the weights is higher than 1.'
        end;end
        if min(min(BinConnMat < 0)),
            'There was an error with keeping the weights, one of the weights is lower than 0'
        end
    end
end


end