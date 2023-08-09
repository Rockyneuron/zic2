function[im_aux]=rotar_imagen(im,rot)
% rot=10;
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
  inter=rot_aux+rot;  
     
else
    
    inp='sacabo'
    
end
    
    
    


end
end


