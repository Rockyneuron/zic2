function[roi,Iseg]=grey_segementation(I,roi_aux)

%%
%GLOBAL THRESHOLDING: 
%2 METHODS THAT GIVE APROXIMATE resultspara obtener de forma autómatica el
%umbrel T que usaremos para segementar la imagen
f=mat2gray(I);

%1)Iterative procedure proposed by gonzales
T=0.5*(double(min(f(:)))+double(max(f(:)))); %T0=0.5 ya que ek histograma esta nomalizado entre 0 y 1
done=false;
while ~done
    g=f>=T;
    Tnext=0.5*(mean(f(g))+mean(f(~g)));
    done=abs(T-Tnext)<0.5;
    T=Tnext;
end
BW1 = ~im2bw(I,T);

figure, imagesc(BW1), colormap gray, axis image
%%
%      g = splitmerge(I, 2, @(x) mean2(x)<T) ;
%       figure, imagesc(g), axis image, colormap jet, axis image

      
      

%%
%Labbeling conected componentes%
%Utlizando N4 o N8 para definir la adyacencia entre pixels se cuantifica
%cuales estan conectados en la imagen y , por tanto, que forman objetos
%independientes.

%[L,M]=bwlabel(f,conn)

f =  BW1;
con=4;
[L,M]=bwlabel(f,con); %veo y distingo los elementos que estan conectados

%identifico los elementos
nel=max(L(:)); %numero de elementos diferentes
work_label=[];
for i=1:nel
   [row,col]=find(L==i) ;
   Mrow=mean(row(:));
   Mcol=mean(col(:));
   

   work_label=[work_label [ Mrow;Mcol]];
end

% figure,
% ax1=subplot(1,2,1)
% imagesc(L), colorbar, axis image,colormap jet
% ax2=subplot(1,2,2)
% imagesc(g), colorbar, axis image
% colormap(ax2,gray)
% hold on
% plot(work_label(2,:),work_label(1,:),'o')

%%
%Identifico los elementos mas comunes diferentes de 0 
L=L.*roi_aux;
 [index_1]=find(L~=mode(L(find(L))));
 
 out_1=L;
 out_1(index_1)=0;
 
 %%
 %Morfolorgical image procesing, relleno huecos
 
 f=out_1;
 se=strel('diamond',1)
fo=imopen(f,se);
% imshow(fo)

fc=imclose(f,se);
% imshow(fc)

foc=imclose(fo,se);
% imshow(foc)
fmor=bwmorph(f,'open',inf);

roi=im2bw(foc);

figure,
subplot(2,2,1)
imshow(f),title('image')
subplot(2,2,2)
imshow(fmor),title('open')
subplot(2,2,3)
imshow(fc),title('close')
subplot(2,2,4)
imshow(foc),title('open-close')

figure,
subplot(1,3,1)
imagesc(I), axis image, colormap gray
subplot(1,3,2)
imagesc(roi), axis image, colormap gray
subplot(1,3,3)
imagesc(I.*roi), axis image, colormap gray
% Iseg=I*roi;

end