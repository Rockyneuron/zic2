
function[ipsi_resp]=column_delimitation(ipsi_A,thr)


%Morphological operations


f=ipsi_A;
se=strel('square',5)
fo=imopen(f,se);
imshow(fo)

fc=imclose(f,se);
imshow(fc)

foc=imclose(fo,se);
imshow(foc)

figure,
subplot(2,2,1)
imshow(f),title('image')
subplot(2,2,2)
imshow(fo),title('open')
subplot(2,2,3)
imshow(fc),title('close')
subplot(2,2,4)
imshow(foc),title('open-close')




%%
%label conected components
figure,
f =fo ;
con=8;
[L,M]=bwlabel(f,con); %veo y distingo los elementos que estan conectados
imagesc(f), axis image, colormap gray
%identifico los elementos
nel=max(L(:)); %numero de elementos diferentes
work_label=[];
work_col_area=[];
for ii=1:nel
   [row,col]=find(L==ii) ;
   Mrow=mean(row(:));
   Mcol=mean(col(:));
   
area=length(find(L==ii))/80^2;
   work_label=[work_label [ Mrow;Mcol]];
   work_col_area=[work_col_area area];
   hold on
text(work_label(2,ii),work_label(1,ii),num2str(area),'Color','red')

   
end

plot(work_label(2,:),work_label(1,:),'o')

%%
%delete small areas, columns of v1 response
ele=work_col_area>thr;
values=1:1:length(ele);
values=values(ele);
index_1=ismember(L,values);
ipsi_resp=index_1;

 figure, imagesc(ipsi_resp), colormap gray, axis image
 
 
end
