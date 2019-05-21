function [Qtot Qpart Qin Qout] = CalculateModularity(files_in),
%Will measure the modularity of of a matrix containing relationship
%values between different nodes. 
%
%files_in
%	.matrix		matrix, relationship between nodes, must be
%				between -1 and 1
%	.part		vector, for each node of the matrix, specifiy
%				which cluster a node belongs to. 
%

%set variables
part = files_in.part;
natoms = length(part);

matrix = files_in.matrix.*abs(eye(natoms)-1);

sumWei = sum(matrix(:));



sumQ = 0;

%%% big loop
%for ii = 1:natoms,
%	ssq = 0;
%	for jj = 1:natoms,
%		if ii ~= jj, if part(ii) == part(jj),
%			sumQ = sumQ + ( matrix(ii,jj) - ( ( sum(matrix(ii,:)) * sum(matrix(jj,:)) ) / sumWei ) );
%		end;end
%	end
%end

FinalQ = sumQ/sumWei;




%%% Trail for new type of Q appraising
uPart = unique(part);
Qtot = 0;
Qpart = zeros(size(part));
Qin = 0;
Qout = 0;

%Loop for all modules
for pp = 1:length(uPart),

	iLoc = find(part == pp);
	oLoc = find(part ~= pp);
	
	iWei = matrix(iLoc,iLoc);
	oWei = matrix(iLoc,:);

	tQpart = (sum(iWei(:))/sumWei) - (( sum(oWei(:))/sumWei )^2);

    tqin = sum(iWei(:));
    tqout = sum(oWei(:));

	Qtot = Qtot + tQpart;
	Qpart(find(part == pp)) = tQpart;
	Qin = Qin+tqin;
    Qout = Qout+tqout;
end
end