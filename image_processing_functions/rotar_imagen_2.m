function[im_aux]=rotar_imagen_2(im,rot)
rot=10;
inter=0;

figure, imagesc(im), axis image, colormap gray


inp=0;
while isfloat(inp)
    
    
     
 frame=input('rotate'); 

if frame ==1
     rot_aux=rot+inter;
    
    im_aux=imrotate(im,rot_aux);
    
   hold on 
    imagesc(im_aux), axis image, colormap gray
     
elseif frame==2
         rot_aux=inter-rot;

    im_aux=imrotate(im,-1*rot_aux);
    
  
    imagesc(im_aux), axis image, colormap gray    
else
    
    inp='sacabo'
 
end
    
     inter=(rot_aux+rot);     
       
  
end
    
 

end



