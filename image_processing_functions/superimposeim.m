function[hf]=superimposeim(im1,im2,alfa1,alfa2)

vec1=1:size(im1,1);
vec2=1:size(im1,2);


% New figure
hf=figure;
% Background image
h1= axes;
p1=imagesc(im2),axis image;
% c1=colorbar;
colormap(h1,jet);
set(h1,'color','none','visible','off','ydir','reverse','xlim',[vec2(1) vec2(end)],'ylim',[vec1(1) vec1(end)]);
% Foreground image
h2=axes;
p2=imagesc(im1),axis image;
% c2=colorbar;
set(h2,'color','none','visible','off');
colormap(h2,gray);
set(h1,'color','none','visible','off','ydir','reverse','xlim',[vec2(1) vec2(end)],'ylim',[vec1(1) vec1(end)]);
set(p2, 'AlphaData',alfa1); % .5 transparency
set(p1, 'AlphaData',alfa2); % .5 transparency
set([h1, h2],'XTick',[],'YTick',[]);
% c1.Location='westoutside';
% c1.Position= c1.Position-[0.05 0 0 0];
% c2.Position= c2.Position+[0.05 0 0 0];
% c2.Limits=[-1 1];
% set(h2,'ydir','reverse','xlim',[vec1(1) vec1(end)],'ylim',[vec1(1) vec1(end)]);
% set(h1,'ydir','reverse','xlim',[vec1(1) vec1(end)],'ylim',[vec1(1) vec1(end)]);
end