%This script will map in how many participants each atoms is part of a
%small graph. Small graph is defined as containing nAtoms or less number of
%atoms.
addpath('F:\MatlabToolboxes\StatsTests');
fs = filesep;

%%%%%%
% Options
%%%%%%
q = 0.01;

nAtoms = 5;

pAtoms = 'F:\Modularity\fmri\region_growing_RestOnly_CBSCMixed_OccMask\rois\brain_rois.nii';%path to volume with atoms
pSize = 'F:\GraphAnalysis\results\Occ_X_90\Smooth\NoMst\sci190_scg190_scf190\SizeComp.mat';
[OutP, xx, yy, zz] = fileparts(pSize);

groups = {'CB' 'SC'};
cond = {'rest'};
ext = {'mat'};
fn = {'thr_10' 'thr_25' 'thr_40' 'thr_50'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Star script
load(pSize);
[hdr, atoms] = niak_read_vol(pAtoms);


for cc = 1:length(cond),
    for ee = 1:length(ext),
        for ff = 1:length(fn),
            for gg = 1:length(groups),
                
                %Calculate proportion values
                fmat = SizeComp.(cond{cc}).(groups{gg}).(ext{ee}).(fn{ff}).mat;
                loc = find(fmat < nAtoms);
                tmat = zeros(size(fmat));
                tmat(loc) = 1;

                gres{gg} = sum(tmat,2);
                gnum{gg} = size(tmat,2);
                res = gres{gg}./gnum{gg};
                
                %Create and fille volume
                vol = zeros(size(atoms));
                for aa = 1:length(unique(atoms))-1,
                    tloc = find(atoms == aa);
                    vol(tloc) = res(aa);
                end
                hdr.file_name = strcat(OutP,fs,'CompSize_',cond{cc},'_',groups{gg},'_',ext{ee},'_',fn{ff},'.nii');
                %niak_write_vol(hdr,vol);
            end
            
            %%%%% 
            % Writing the fdr corrected volume of Chi2 test
            %%%%%
            OO = zeros(2,2,length(gres{1}));
            
            OO(1,1,:) = gres{1};OO(1,2,:) = gres{2};
            OO(2,1,:) = gnum{1}-gres{1};OO(2,2,:) = gnum{2}-gres{2};
            
            %chitest
            [ChiVal df] = ChiTest(OO,[]);
            pce = chi2cdf(ChiVal,df);
            [fdr,test] = niak_fdr(pce,'BH',q);
            res = test.*ChiVal;
            
            %write volume
            vol = zeros(size(atoms));
            for aa = 1:length(unique(atoms))-1,
                    tloc = find(atoms == aa);
                    vol(tloc) = res(aa);
            end
            hdr.file_name = strcat(OutP,fs,'CompSize_CHI_',cond{cc},'_',ext{ee},'_',fn{ff},'.nii');
            %niak_write_vol(hdr,vol);
        end
    end
end

