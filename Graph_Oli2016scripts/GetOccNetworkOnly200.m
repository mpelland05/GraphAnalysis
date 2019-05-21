fName = 'F:\GraphAnalysis\raw\200\CompiledConnectivityMatrices.mat';
Nets = [11 27 29 30 34 38 59 60 82 83 87 88 111 116 119 120 122 125 145 147 159 161 163 173 174 179 182 183 193 199];

load(fName)

Groups = {'CB' 'LB' 'SC'};
Cond = {'rest' 'task'};

for gg = 1:length(Groups),
    for cc = 1:length(Cond),        
        ConnMatrix.(Cond{cc}).(Groups{gg}).Occ = ConnMatrix.(Cond{cc}).(Groups{gg}).mat(Nets,Nets,:);
    end
end

save(fName,'ConnMatrix')