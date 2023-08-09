function[]=exploreall_dataframes(im,min_r,max_r)



fac=[0 0 0 0.01 ];
plot_exp(im,fac,min_r,max_r),set(gcf,'Name',inputname(1))   

  

function[]=plot_exp(im,fac,min_r,max_r)
   figure
for i=1:size(im,3)
%       min_r=min(im(:));
%     max_r=max(im(:));
    subplot(4,5,i)
    pos=get(gca,'Position');I=im(:,:,i);
    imagesc(I,[min_r,max_r]), axis image, colormap gray,set(gca,'YTick',[],'XTick',[],'Position',pos+fac)
%   title(['un' num2str(length(unique(I))) ' ' num2str(round(log2(length(unique(I))),3)) 'bits' '[' num2str(min(I(:)))...
%       ' , ' num2str(max(I(:))) ']'])

title([num2str(round(log2(length(unique(I))),3)) ' bits ' '[' num2str(min(I(:)))...
      ' , ' num2str(max(I(:))) ']'],'FontSize', 7)

end
    end
        
        
end