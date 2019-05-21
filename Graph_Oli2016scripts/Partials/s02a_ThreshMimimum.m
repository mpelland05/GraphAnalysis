function MinThresh = s02a_ThreshMimimum_p(ConnMatrix),
%Find mimimal threshold for groups of data

SecoP = {'Rest', 'Task'};
Groups = {'CB', 'SC'};
mSize = 100;%Size of matrix

thresh = 1;

for ii = 1:length(SecoP),
    for jj = 1:length(Groups),
        [xx yy zz] = size(ConnMatrix.(SecoP{ii}).(Groups{jj}).mat); %finds number of participants
        for kk = 1:zz,
            %find threshold for each participants
            [BinConnMat thresh] = s02_Thresh(ConnMatrix.(SecoP{ii}).(Groups{jj}).mat(:,:,kk),'single','yo',thresh, 'yes');
            [ii jj kk];
        end
    end
end

MinThresh = thresh;
end