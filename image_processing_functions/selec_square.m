function[roi]=selec_square(I, len,wid)
%--------------------------------------------------------------------------
% Function for selecting a rectangle or square of fixed dimensions
% inputs:
% I....................................Image 
% len.................................rectangle length
% wid.................................rectantgle width
% output:
% roi................................Final roi selected

%--------------------------------------------------------------------------
%%%backgorund
figure,
imagesc(I), colormap gray,axis image, title('select background')
     h_rect = imrect(gca,[100  100 len wid]);
setFixedAspectRatioMode(h_rect,0)
setResizable(h_rect,0) 
input('Press intro to accept location');
% Rectangle position is given as [xmin, ymin, width, height]
 pos_rect = getPosition(h_rect);
% Round off so the coordinates can be used as indices
pos_rect = round(pos_rect);
% Select part of the image
roi=[pos_rect(2) + (0:pos_rect(4)); pos_rect(1) + (0:pos_rect(3))];
img_map = I(roi(1,:),roi(2,:));
% histograma del ROI
proi=imhist(img_map);
roi=zeros(size(I));
a=[pos_rect(2) + (0:pos_rect(4)); pos_rect(1) + (0:pos_rect(3))];
roi(a(1,:),a(2,:))=1;

end