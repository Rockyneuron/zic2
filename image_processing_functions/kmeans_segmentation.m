function[index_1]=kmeans_segmentation(Imap)

I = Imap;
I = im2double(I);
[idx,c,sumd,D]= kmeans(I(:), 3);
p = reshape(idx, [size(I)]);


figure, imagesc(p)
h=hist(p(:));
h=h(find(h));

figure, bar(h(:))

index_1=p==1 | p==2;
index_2=p==2| p==2;

 figure, imagesc(index_1),axis image, colorbar
 
figure, imagesc(p),axis image, colorbar


 
 
 figure, imagesc(Imap), colormap gray, axis image
 
 
segmented=p(index_1);

 
 figure, imagesc(segmented), colormap gray, axis image
 

% %%
% %%%Labbeling conected componentes%
% %Utlizando N4 o N8 para definir la adyacencia entre pixels se cuantifica
% %cuales estan conectados en la imagen y , por tanto, que forman objetos
% %independientes.
% 
% f =  index_1;
% con=8;
% [L,M]=bwlabel(f,con); %veo y distingo los elementos que estan conectados
% 
% %identifico los elementos
% nel=max(L(:)); %numero de elementos diferentes
% work_label=[];
% for i=1:nel
%    [row,col]=find(L==i) ;
%    Mrow=mean(row(:));
%    Mcol=mean(col(:));
%    
% 
%    work_label=[work_label [ Mrow;Mcol]];
% end
% 
% figure,
% ax1=subplot(1,2,1)
% imagesc(L), colorbar, axis image,colormap jet
% ax2=subplot(1,2,2)
% imagesc(Imap), colorbar, axis image
% colormap(ax2,gray)
% hold on
% plot(work_label(2,:),work_label(1,:),'o')
% colormap gray
% 
% %%
% g=index_1;
% g2=index_2;
% 
% se=strel('square',2);
% gthick=imdilate(g,se); %dilation cuadrada par ensachar un `poco los bordes
%  figure, imshow(gthick)
% 
% Lfill=imfill(g,'holes'); %me quedo con los bordes
%  figure, imshow(Lfill)
% Lfill2=imfill(g2,'holes'); %me quedo con los bordes
% figure, imshow(Lfill2)
%  
% gthick=imdilate(Lfill,se); %dilation cuadrada par ensachar un `poco los bordes
%  figure, imshow(gthick)
% gthick=imdilate(Lfill2,se); %dilation cuadrada par ensachar un `poco los bordes
%  figure, imshow(gthick)
% 
%  
 

% 
% figure,
% subplot(2,2,1)
% imshow(f),title('image')
% subplot(2,2,2)
% imshow(fmor),title('open')
% subplot(2,2,3)
% imshow(fc),title('close')
% subplot(2,2,4)
% imshow(foc),title('open-close')
% %%
% %%
% %Identifico los elementos mas comunes diferentes de 0 
%  [index_1]=find(L~=mode(L(find(L))));
%  
%  out_1=L;
%  out_1(index_1)=0;
 
%%

% 
% 
% 
% figure,
% subplot(1,3,1)
% imagesc(Imap), axis image, colormap gray
% subplot(1,3,2)
% imagesc(out_1), axis image, colormap gray
% subplot(1,3,3)
% imagesc(Imap.*out_1), axis image, colormap gray
end