function CompareDiCePaired(files_in,files_out),
%files_in.scales = 100;
%files_in.groups = {'CBxxx'};
%files_in.path = 'F:\Modularity\Results\AvgValTestMod.mat';
%files_in.numPermutations = 1000000;
%files_in.contrast_name = 'CBvsSC_100';
%files_out = 'F:\Modularity\Results\PermValTestMod.mat';
%Modified from first version to be faster by doing calculations only once
%per atom.

%General preparation
load(files_in.path);

Perm.Legend = Avg.Legend;
Perm.Atoms = Avg.Atoms;
Perm.VoxelsIdx = Avg.VoxelsIdx;
Perm.ParticipantsIdx = Avg.ParticipantsIdx;
Perm.Parameters = Avg.Parameters;
Perm.Parameters.NumPerm = files_in.numPermutations;


%Read atoms and squeeze the number of tests-> Does only one test per atom
[hdr Atm] = niak_read_vol(Avg.Atoms);

Atom = Atm(Avg.VoxelsIdx);clear Atm;
uAtom = unique(Atom);
uAtom(find(uAtom == 0)) = [];

for uu = 1:length(uAtom),
    temp = find( Atom == uAtom(uu) );
    Loc(uu) = temp(1);    
end
size(Loc)

%Launch the Permutation test
group1 = Avg.(files_in.ScaleStr).Self_CBxxx(Loc,:);
group2 = Avg.(files_in.ScaleStr).CBxxx_vs_SCxxx(Loc,:);

[pvalues Average STDev] = PairedPermutationTest(group1,group2,files_in.numPermutations,files_in.groups);

Perm.(files_in.contrast_name).pvalues = zeros(length(Perm.VoxelsIdx),1);
Perm.(files_in.contrast_name).Average = zeros(length(Perm.VoxelsIdx),1);
Perm.(files_in.contrast_name).STDev = zeros(length(Perm.VoxelsIdx),1);


%Unsqueeze information from atom to voxels
for uu = 1:length(uAtom),
    temp = find( Atom == uAtom(uu) );
    
    Perm.(files_in.contrast_name).pvalues(temp) = pvalues(uu);
    Perm.(files_in.contrast_name).Average(temp) = Average.(files_in.groups{1})(uu);
    Perm.(files_in.contrast_name).STDev(temp) = STDev.(files_in.groups{1})(uu);
end

save(files_out,'Perm');

end
