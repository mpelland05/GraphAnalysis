function CompareDiCePairedPipe(files_in,files_out,opt),
%%files_in = 'F:\Modularity\Results\AvgValTestMod.mat';
%%files_out = 'F:\Modularity\Results\PermValTestMod.mat';
%opt.scalestr = 'L36';
%opt.groups = {'CBxxx'};
%opt.numPermutations = 1000000;
%opt.contrast_name = 'CBvsSC_100';
%Modified from first version to be faster by doing calculations only once
%per atom.

%General preparation
load(files_in);

Perm.Legend = Avg.Legend;
Perm.Atoms = Avg.Atoms;
Perm.VoxelsIdx = Avg.VoxelsIdx;
Perm.ParticipantsIdx = Avg.ParticipantsIdx;
Perm.Parameters = Avg.Parameters;
Perm.Parameters.NumPerm = opt.numPermutations;


%Read atoms and squeeze the number of tests-> Does only one test per atom
[hdr Atm] = niak_read_vol(Avg.Atoms);

Atom = Atm(Avg.VoxelsIdx);clear Atm;
uAtom = unique(Atom);
uAtom(find(uAtom == 0)) = [];

for uu = 1:length(uAtom),
    temp = find( Atom == uAtom(uu) );
    Loc(uu) = temp(1);    
end

%Launch the Permutation test
group1 = Avg.(opt.scalestr).Self_CBxxx(Loc,:);
group2 = Avg.(opt.scalestr).CBxxx_vs_SCxxx(Loc,:);

[pvalues Average STDev] = PairedPermutationTest(group1,group2,opt.numPermutations,opt.groups);

Perm.(opt.contrast_name).pvalues = zeros(length(Perm.VoxelsIdx),1);
Perm.(opt.contrast_name).Average = zeros(length(Perm.VoxelsIdx),1);
Perm.(opt.contrast_name).STDev = zeros(length(Perm.VoxelsIdx),1);


%Unsqueeze information from atom to voxels
for uu = 1:length(uAtom),
    temp = find( Atom == uAtom(uu) );
    
    Perm.(opt.contrast_name).pvalues(temp) = pvalues(uu);
    Perm.(opt.contrast_name).Average(temp) = Average.(opt.groups{1})(uu);
    Perm.(opt.contrast_name).STDev(temp) = STDev.(opt.groups{1})(uu);
end

save(files_out,'Perm');

end
