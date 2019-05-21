%This script takes a full connectome and extract a connectome of sub areas,
%like the occipital lobe. 

fName = 'F:\GraphAnalysis\raw\200\CompiledConnectivityMatrices';

ConnMatrix.Mask = 'F:\Connectivity\glm_connectome_aout_2013\GLM01_complete_nosex\sci8_scg8_scf8\networks_sci8_scg8_scf8.nii.gz';

Nets{1} = [2 20 33 39 55 62 63 78 79 80 85 94 102 106 112 114 117 134 155 164 166 169 170 194 197];
NName{1} = 'Cerebellum';

Nets{2} = [7 13 32 40 42 44 47 49 81 90 96 108 109 130 152 165 168 178 188 190 191];
NName{2} = 'DMN';

Nets{3} = [6 21 53 56 68 72 98 104 121 138 140 143 153 156 162 180 187 192];
NName{3} = 'Auditory';

Nets{4} = [4 5 12 15 25 46 50 69 89 175];
NName{4} = 'Thalamus';

Nets{5} = [1 8 9 16 31 36 37 52 64 66 75 93 97 98 100 128 132 136 138 142 149 158 160 171 172 177 184 185 189 198];
NName{5} = 'Sensorimotor';

Nets{6} = [ 3 10 14 18 19 26 28 45 48 51 57 67 70 71 73 77 95 101 103 115 118 123 135 141 144 146 157 162 180 181 195 196 200];
NName{6} = 'Temporal_ventroFrontal';

Nets{7} = [17 22 23 24 41 43 54 61 65 74 76 86 91 92 96 97 99 105 107 108 110 113 124 126 127 129 131 135 136 137 139 142 143 148 149 150 151 153 154 167 168 171 176 186 189 191 196 198 200];
NName{7} = 'Fronto_Parietal';

Nets{8} = [11 27 29 30 34 35 38 58 59 60 82 83 84 87 88 111 116 119 120 122 123 125 133 144 145 147 157 159 161 163 166 173 174 179 182 183 193 199];%List of regions in network 1
NName{8} = 'Occ';%Name of network 1


load(strcat(fName,'.mat'));

Groups = {'CB' 'LB' 'SC'};
Cond = {'rest' 'task'};

for gg = 1:length(Groups),
    for cc = 1:length(Cond),
        for nn = 1:length(Nets),
            ConnMatrix.(Cond{cc}).(Groups{gg}).(NName{nn}) = ConnMatrix.(Cond{cc}).(Groups{gg}).mat(Nets{nn},Nets{nn},:);
            ConnMatrix.Net_index.(NName{nn}) = Nets{nn};
        end
    end
end



save(strcat(fName,'_8Net.mat'),'ConnMatrix')