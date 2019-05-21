%Launch Compare_Overlap_Maps
files_in.path = 'F:\MyStudies\Modularity\Modularity_OC_2016\Results\Comp_overlap';
files_in.groups = {'CBxx' 'SCxx'};
files_in.n_size = [14 17];
files_in.threshold = 1.644;%equivalent to 0.05twotailed    1.644; %equivalent to 0.1 two tailed
files_out = 'diff_unc_01';

Compare_Overlap_Maps(files_in,files_out);

