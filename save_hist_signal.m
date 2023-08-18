
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ferret Exctract data%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
fid = fopen('exp.txt');
data = textscan(fid,'%s');
fclose(fid);
mouse=data{1,1}
cd analysed
for ii =1:length(mouse)

cd(mouse{ii})
load(mouse{ii})

[h,p,ci,stats]=ttest2(data.seg.contra_raw(:),data.seg.ipsi_raw(:),'Vartype','unequal');
stats.tstat

hist_signal=figure, histogram(data.seg.contra_raw(:)), title(['seg contra/ipsi z='  num2str(round(stats.tstat))]),hold on,
histogram(data.seg.ipsi_raw(:)),legend('contra','ipsi')
saveas(hist_signal,'hist_signal.png')  
cd('..')

close all
end


