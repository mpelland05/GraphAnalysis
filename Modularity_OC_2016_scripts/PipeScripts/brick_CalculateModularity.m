function brick_CalculateModularity(files_in,files_out),
%Will measure the modularity of of a matrix containing relationship
%values between different nodes. 
%
%files_in
%	.path		string, path to stability_ind	
%files_out 		string, full path to .mat file unto which results
%				will be saved

fs= filesep;
if strcmp(files_in.path(end),fs), files_in.path = files_in.path(1:end-1);end;

%%%%%%%%
%find list of folder names using  files_in.path
%%%%%%%%
tdir = dir(files_in.path);
tnam = find(vertcat(tdir.isdir) == 1);

for tt = 1:length(tnam), tpnames{tt} = tdir(tnam(tt)).name;end

%Remove . and ..
tt = find(strcmp(tpnames,'.'));
if ~isempty(tt),tpnames{tt} = [];end
tt = find(strcmp(tpnames,'..'));
if ~isempty(tt),tpnames{tt} = [];end

ff = 1;
for pp = 1:length(tpnames),
    if ~isempty(tpnames{pp}),
	tpath = strcat(files_in.path, fs, tpnames{pp},fs,'stability_ind_',tpnames{pp},'.mat')

	%specify variables
	tstruct = load(tpath);
	stab = tstruct.stab;
	nb_classes = tstruct.nb_classes;
	part = tstruct.part;
	nscal = length(nb_classes);

	%set variables when first participant is analyzed
	if ff == 1, Results.ModularitValue = zeros(length(tpnames),nscal);ff = 0; end;
	
	for ss = 1:nscal,
		%Launch CalculateModularity
		fi.matrix = niak_vec2mat(squeeze(stab(:,ss)));
		fi.part = part(:,ss);
		[t1 t2 t3 t4]= CalculateModularity(fi);
		Results.ModularitValue(pp,ss) = t1;
		Results.Qin(pp,ss) = t3;
        Results.Qout(pp,ss) = t4;
	end
    end	
end

Results.legend = '1st dimension (row) is participant, second dimension (column) is scale';
Results.scales = nb_classes;

save(files_out,'Results');
%xlswrite(strcat(files_out(1:end-3),'.xls'),Results.ModularitValue,'Qvalue');
%xlswrite(strcat(files_out(1:end-3),'.xls'),Results.legend,'Legend');
%xlswrite(strcat(files_out(1:end-3),'.xls'),Results.scales,'Scales');

%notes
%stab = vec x part
%nb_classes = numbers of scales
%part = natoms x scales
