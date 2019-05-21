function Get_Avg_Std(files_in),
%Collets modularity and NNet to make comparisons by groups

BaseP = files_in.BaseP
ext = files_in.ext;
otname = files_in.tname;
p1 = files_in.p1;
p2 = files_in.p2;

aa = load(strcat( BaseP,otname{1,1},'.mat' ));
bb = load(strcat( BaseP,otname{1,2},'.mat' ));
cc = load(strcat( BaseP,otname{1,3},'.mat' ));
dd = load(strcat( BaseP,otname{1,4},'.mat' ));
%ee = load(strcat( BaseP,otname{1,4},'.mat' ));

if strcmp(otname{1,1}(numel(otname{1,1})), '0' ), 
    tname{1,1} = otname{1,1}(1:end-4);
    tname{1,2} = otname{1,2}(1:end-4);
    tname{1,3} = otname{1,3}(1:end-4);
    tname{1,4} = otname{1,4}(1:end-4);
    %tname{1,5} = otname{1,5}(1:end-4);
else
    tname = otname;
end

fn = orderfields( aa.(tname{1,1}).(p1{1}).(p1{2}).(ext)  );
fnn = fieldnames(fn);
loc = find(cellfun('length',fnn) == 5);

if ~isempty(loc),
    tve = 1:length(fnn); tve(loc) = []; ve = [loc tve];
    
    fn = orderfields( fn , ve ); fn = fieldnames(fn);
else
    fn = orderfields( fn ); fn = fieldnames(fn); 
end


%Find the names of the threshol
fn2 = orderfields( aa.(tname{1,1}).(p1{1}).(p1{2}).(ext) ); 
fnn2 = fieldnames(fn2);
loc = find(cellfun('length',fnn2) == 5);

if ~isempty(loc),
    tve = 1:length(fnn2); tve(loc) = []; ve = [loc tve];
    
    fn2 = orderfields( fn2 , ve ); fn2 = fieldnames(fn2);
else
    fn2 = orderfields( fn2 ); fn2 = fieldnames(fn2); %Find the names of the thresholds
end

for ii = 1:length(fn)
    a1(:,ii) = [aa.(tname{1,1}).(p1{1}).(p1{2}).(ext).(fn{ii}).Avg; aa.(tname{1,1}).(p1{1}).(p1{2}).(ext).(fn{ii}).Std];
    a2(:,ii) = [aa.(tname{1,1}).(p2{1}).(p2{2}).(ext).(fn{ii}).Avg; aa.(tname{1,1}).(p2{1}).(p2{2}).(ext).(fn{ii}).Std];
    
    b1(:,ii) = [bb.(tname{1,2}).(p1{1}).(p1{2}).(ext).(fn{ii}).Avg; bb.(tname{1,2}).(p1{1}).(p1{2}).(ext).(fn{ii}).Std];
    b2(:,ii) = [bb.(tname{1,2}).(p2{1}).(p2{2}).(ext).(fn{ii}).Avg; bb.(tname{1,2}).(p2{1}).(p2{2}).(ext).(fn{ii}).Std];
    
    c1(:,ii) = [cc.(tname{1,3}).(p1{1}).(p1{2}).(ext).(fn{ii}).Avg; cc.(tname{1,3}).(p1{1}).(p1{2}).(ext).(fn{ii}).Std];
    c2(:,ii) = [cc.(tname{1,3}).(p2{1}).(p2{2}).(ext).(fn{ii}).Avg; cc.(tname{1,3}).(p2{1}).(p2{2}).(ext).(fn{ii}).Std];
    
    d1(:,ii) = [dd.(tname{1,4}).(p1{1}).(p1{2}).(ext).(fn{ii}).Avg; dd.(tname{1,4}).(p1{1}).(p1{2}).(ext).(fn{ii}).Std];
    d2(:,ii) = [dd.(tname{1,4}).(p2{1}).(p2{2}).(ext).(fn{ii}).Avg; dd.(tname{1,4}).(p2{1}).(p2{2}).(ext).(fn{ii}).Std];
end

for nn = 1:(length(fn2)-1),
    %e1(:,nn) = [ee.(tname{1,5}).(p1{1}).(p1{2}).(ext).(fn2{nn}).Avg; ee.(tname{1,5}).(p1{1}).(p1{2}).(ext).(fn2{nn}).Std];
    %e2(:,nn) = [ee.(tname{1,5}).(p2{1}).(p2{2}).(ext).(fn2{nn}).Avg; ee.(tname{1,5}).(p2{1}).(p2{2}).(ext).(fn2{nn}).Std];
end

alp = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' 'aa' 'bb' 'cc' 'ee' 'ee' 'ff' 'gg' 'hh' 'ii' 'jj' 'kk' 'll' 'mm' 'nn' 'oo' 'pp' 'qq' 'rr' 'ss' 'tt' 'uu' 'vv' 'ww' 'xx' 'yy' 'zz'];

xx = 1;
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , a1, otname{1,1}, strcat(alp(1), num2str( 3*xx )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , ['g' 'g'; 'g' 'g'], otname{1,1}, strcat(alp(size(a1,2)+1), num2str( 3*xx )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , a2, otname{1,1}, strcat(alp(size(a1,2)+3), num2str( 3*xx )) ); 
   
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , repmat('t',1,size(a1,2)+size(a2,2)+2 ), otname{1,1}, strcat(alp(1), num2str( (3*xx)-1 )) ); 
   
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , b1, otname{1,1}, strcat(alp(1), num2str( 6 )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , ['g' 'g'; 'g' 'g'], otname{1,1}, strcat(alp(size(a1,2)+1), num2str( 6 )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , b2, otname{1,1}, strcat(alp(size(a1,2)+3), num2str( 6 )) ); 
   
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , c1, otname{1,1}, strcat(alp(1), num2str( 9 )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , ['g' 'g'; 'g' 'g'], otname{1,1}, strcat(alp(size(a1,2)+1), num2str( 9 )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , c2, otname{1,1}, strcat(alp(size(a1,2)+3), num2str( 9 )) ); 
   
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , d1, otname{1,1}, strcat(alp(1), num2str( 12 )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , ['g' 'g'; 'g' 'g'], otname{1,1}, strcat(alp(size(a1,2)+1), num2str( 12 )) ); 
   xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , d2, otname{1,1}, strcat(alp(size(a1,2)+3), num2str( 12 )) ); 
   
   %xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , e1, otname{1,1}, strcat(alp(1), num2str( 15 )) ); 
   %xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , ['g' 'g'; 'g' 'g'], otname{1,1}, strcat(alp(size(a1,2)+1), num2str( 15 )) ); 
   %xlswrite( strcat(BaseP, 'ModNNet_Avg_Std.xls') , e2, otname{1,1}, strcat(alp(size(a1,2)+3), num2str( 15 )) ); 



end