


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


imwrite(mat2gray(data.contra_raw.*ROI),'contra_raw_roi.tif')
imwrite(mat2gray(data.ipsi_raw.*ROI),'ipsi_raw_roi.tif')

cd('..')

close all
end


