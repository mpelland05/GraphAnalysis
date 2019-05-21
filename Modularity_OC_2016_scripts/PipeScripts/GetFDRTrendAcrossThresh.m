function GetFDRTrendAcrossThresh(basePath),
%This script will take all the volumes within basepath, find which parts
%are non-zero, transform them into 1 or -1 and add each volume to each
%other. 
%
%This effectively yield a map were high values mean that the same voxel
%crosses the statistical threshold multiple times wereas low (or zero
%values) signify voxels which rarely cross the statistical threshold.

fs = filesep;

if basePath(end) ~= fs,
   basePath = strcat(basePath,fs); 
end

%%%%%%%%
%find list of files names using  basePath
%%%%%%%%
tdir = dir(basePath);
tnam = find(vertcat(tdir.isdir) == 0);

for tt = 1:length(tnam),
    tpnames{tt} = tdir(tnam(tt)).name;
end
	

for vv = 1:length(tpnames),
   [hdr, vol]  = niak_read_vol(strcat(basePath,tpnames{vv}));
   
   if vv == 1,
       %stuff that only needs to be done once for all thresholds. 
       tot_vol = zeros(size(vol));
       
       %know whether the original file is .mnc , .nii and .gz
       [pathstr, name, ext, versn] = fileparts(strcat(basePath,tpnames{vv}));
       if ext == '.gz'
           [bbb, name, ext2, ddd] = fileparts(name);
           ext = strcat(ext2,ext);
       end
       pathstr = strcat(pathstr,fs);
   end
   
   neg = find(vol < 0);
   pos = find(vol > 0);
   
   tot_vol(neg) = tot_vol(neg) -1;
   tot_vol(pos) = tot_vol(pos) +1;
end

mkdir(strcat(pathstr,'OverlapMap'));

hdr.file_name = strcat(pathstr,'OverlapMap',fs,'Overlap_allThresh',ext);
niak_write_vol(hdr,tot_vol);

end