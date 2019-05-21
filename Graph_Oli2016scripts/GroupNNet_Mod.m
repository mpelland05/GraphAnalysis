function GroupNNet_Mod(files_in),
%Collets modularity and NNet to make comparisons by groups

BaseP = files_in.BaseP;
ext = files_in.ext;
otname = files_in.tname;
p1 = files_in.p1;
p2 = files_in.p2;

aa = load(strcat( BaseP,otname{1,1},'.mat' ));
bb = load(strcat( BaseP,otname{1,2},'.mat' ));

if strcmp(otname{1,1}(numel(otname{1,1})), '0' ), 
    tname{1,1} = otname{1,1}(1:end-4);
    tname{1,2} = otname{1,2}(1:end-4);
else
    tname = otname;
end

fn = fieldnames( aa.(tname{1,1}).(p1{1}).(p1{2}).(ext) ); %Find the names of the threshol

for ii = 1:length(fn)
    a1 = [aa.(tname{1,1}).(p1{1}).(p1{2}).(ext).(fn{ii}).mat; bb.(tname{1,2}).(p1{1}).(p1{2}).(ext).(fn{ii}).mat];
    a2 = [aa.(tname{1,1}).(p2{1}).(p2{2}).(ext).(fn{ii}).mat; bb.(tname{1,2}).(p2{1}).(p2{2}).(ext).(fn{ii}).mat];
    
    Comb{1}(:,:,ii) = a1; Comb{2}(:,:,ii) = a2;
end

alp = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff' 'gg' 'hh' 'ii' 'jj' 'kk' 'll' 'mm' 'nn' 'oo' 'pp' 'qq' 'rr' 'ss' 'tt' 'uu' 'vv' 'ww' 'xx' 'yy' 'zz'];

for xx = 1:size(Comb{1},3),
   xlswrite( strcat(BaseP, 'Mod_and_NNet.xls') , Comb{1}(:,:,xx), otname{1,1}, strcat(alp(1), num2str( 3*xx )) ); 
   xlswrite( strcat(BaseP, 'Mod_and_NNet.xls') , ['g' 'g'; 'g' 'g'], otname{1,1}, strcat(alp(size(a1,2)), num2str( 3*xx )) ); 
   
   xlswrite( strcat(BaseP, 'Mod_and_NNet.xls') , Comb{2}(:,:,xx), otname{1,1}, strcat(alp(size(a1,2)+2), num2str( 3*xx )) ); 
   
   xlswrite( strcat(BaseP, 'Mod_and_NNet.xls') , repmat('t',1,size(a1,2)+size(a2,2)+2 ), otname{1,1}, strcat(alp(1), num2str( (3*xx)-1 )) ); 
end

end