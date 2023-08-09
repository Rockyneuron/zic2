

function[data_1,ang_norm,data_2,data_3,data_2_aux,data_4]=map_dif_angles(angmap,ang_norm)
%%%this function extracts and plots the different ways of compuitng the
%%%angles of an orientation.

%map............................. angmap = cardinal + 1i * oblique;

  
load kasmap 
kasmap_aux=[0 0 0;kasmap];
kasmap=kasmap_aux;


data_1=atan((real(angmap)./imag(angmap)));
data_2=atan2(imag(angmap),real(angmap));
data_2_aux=angle(angmap);



data_1=data_1;
  index_1=data_1<0;
data_1(index_1)=pi+data_1(index_1);  %mis valores entre 0 y pi Wolf (2014)
  index_1=data_1<0;
data_1(index_1)=pi+data_1(index_1);  %mis valores entre 0 y pi Wolf (2014)


data_3=data_2./2;
  index_1=data_3<0;
data_3(index_1)=pi+data_3(index_1);  %mis valores entre 0 y pi Wolf (2014)
  index_1=data_3<0;
data_3(index_1)=pi+data_3(index_1);  %mis valores entre 0 y pi Wolf (2014)


data_4=data_2_aux./2;
  index_1=data_4<0;
data_4(index_1)=pi+data_4(index_1);  %mis valores entre 0 y pi Wolf (2014)
  index_1=data_4<0;
data_4(index_1)=pi+data_4(index_1);  %mis valores entre 0 y pi Wolf (2014)



%comprobación importante
%Llegamos la mismo resultado de dos maneras diferents, lo estamos haciendo
%bien
 figure
subplot(2,3,1)
  imagesc(data_1), axis image, colorbar, axis image, title('atan method'), colormap (kasmap),
subplot(2,3,2)
  imagesc(ang_norm), axis image, colorbar, axis image, title('myfunction  method'), colormap (kasmap)
subplot(2,3,3)
  imagesc(data_2), axis image, colorbar, axis image, title('atan2 method'), colormap (kasmap)
subplot(2,3,4)
  imagesc(data_3), axis image, colorbar, axis image, title('atan2=((atan2/2)<0)+pi'), colormap (kasmap)
subplot(2,3,5)
  imagesc(data_2_aux), axis image, colorbar, axis image, title('angle function'), colormap (kasmap)
subplot(2,3,6)
  imagesc(data_4), axis image, colorbar, axis image, title('angle=((angle/2)<0)+pi'), colormap (kasmap)



















end