

function[cumc1,cumc2,cumc3,cumc4,cond1bl,cond2bl,cond3bl,cond4bl]=mouse_montage160218(c0,c1,c2,c3,c4,alfa,pprest,clip,normalization)
%%%%%%%eliminate low frecuency noise with preestimulus frame%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[filas columnas tiempo]=size(c0);


prest_0=(sum(c0(:,:,pprest(1):pprest(2)),3))./length(pprest);
prest_1=(sum(c1(:,:,pprest(1):pprest(2)),3))./length(pprest);
prest_2=(sum(c2(:,:,pprest(1):pprest(2)),3))./length(pprest);
prest_3=(sum(c3(:,:,pprest(1):pprest(2)),3))./length(pprest);
prest_4=(sum(c4(:,:,pprest(1):pprest(2)),3))./length(pprest);

if pprest==0
    blank=c0;
    cond1=c1;
    cond2=c2;
    cond3=c3;
    cond4=c4;

elseif strcmp(normalization,'background subs')|| strcmp(normalization,'dif_back_subs')||   strcmp(normalization,'dif_back_subs_blank')||   strcmp(normalization,'dif_back_subs_cock')
    for i=pprest+1:tiempo
        blank(:,:,i)=c0(:,:,i)-(alfa*prest_0);
        cond1(:,:,i)=c1(:,:,i)-(alfa*prest_1);
        cond2(:,:,i)=c2(:,:,i)-(alfa*prest_2);
        cond3(:,:,i)=c3(:,:,i)-(alfa*prest_3);
        cond4(:,:,i)=c4(:,:,i)-(alfa*prest_4);
    end
else
    for i=pprest+1:tiempo
        blank(:,:,i)=c0(:,:,i)./(alfa*prest_0);
        cond1(:,:,i)=c1(:,:,i)./(alfa*prest_1);
        cond2(:,:,i)=c2(:,:,i)./(alfa*prest_2);
        cond3(:,:,i)=c3(:,:,i)./(alfa*prest_3);
        cond4(:,:,i)=c4(:,:,i)./(alfa*prest_4);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%Single condition and diferential maps%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cock=cond1+cond2+cond3+cond4;


if strcmp(normalization,'blank')
    cond1bl=cond1./blank;
    cond2bl=cond2./blank;
    cond3bl=cond3./blank;
    cond4bl=cond4./blank;
    [cumc1,cumc2,cumc3,cumc4]=image_view(cond1bl,cond2bl,cond3bl,cond4bl,pprest,tiempo,clip);
end


if strcmp(normalization,'cocktail')
    cond1bl=cond1./cock;
    cond2bl=cond2./cock;
    cond3bl=cond3./cock;
    cond4bl=cond4./cock;
    [cumc1,cumc2,cumc3,cumc4]=image_view(cond1bl,cond2bl,cond3bl,cond4bl,tiempo,clip);
end

if strcmp(normalization,'background div')|| strcmp(normalization,'background subs')
    cond1bl=cond1;
    cond2bl=cond2;
    cond3bl=cond3;
    cond4bl=cond4;
    [cumc1,cumc2,cumc3,cumc4]=image_view(cond1bl,cond2bl,cond3bl,cond4bl,tiempo,clip);
end


if strcmp(normalization,'dif_back_div')
    dif2_1=(cond2-cond1);
    dif3_4=(cond3-cond4);
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif2_1(:,:,i),clip);
        cellc1(:,:,:,i)=double2rgb(aux_1, gray);
    end
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif3_4(:,:,i),clip);
        cellc2(:,:,:,i)=double2rgb(aux_1, gray);
    end
    figure,montage(cellc1,gray),title('dif1 2 cocktail')
    figure,montage(cellc2,gray),title('dif3 4 cocktail')
end


if strcmp(normalization,'dif_back_div_blank')
    dif2_1=(cond2-cond1)./blank;
    dif3_4=(cond3-cond4)./blank;
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif2_1(:,:,i),clip);
        cellc1(:,:,:,i)=double2rgb(aux_1, gray);
    end
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif3_4(:,:,i),clip);
        cellc2(:,:,:,i)=double2rgb(aux_1, gray);
    end
    figure,montage(cellc1,gray),title('dif1 2 cocktail')
    figure,montage(cellc2,gray),title('dif3 4 cocktail')
end


if strcmp(normalization,'dif_back_div_cock')
    dif2_1=(cond2-cond1)./cock;
    dif3_4=(cond3-cond4)./cock;
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif2_1(:,:,i),clip);
        cellc1(:,:,:,i)=double2rgb(aux_1, gray);
    end
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif3_4(:,:,i),clip);
        cellc2(:,:,:,i)=double2rgb(aux_1, gray);
    end
    figure,montage(cellc1,gray),title('dif1 2 cocktail')
    figure,montage(cellc2,gray),title('dif3 4 cocktail')
end



if strcmp(normalization,'dif_back_subs')
    dif2_1=(cond2-cond1);
    dif3_4=(cond3-cond4);
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif2_1(:,:,i),clip);
        cellc1(:,:,:,i)=double2rgb(aux_1, gray);
    end
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif3_4(:,:,i),clip);
        cellc2(:,:,:,i)=double2rgb(aux_1, gray);
    end
    figure,montage(cellc1,gray),title('dif1 2 cocktail')
    figure,montage(cellc2,gray),title('dif3 4 cocktail')
end


if strcmp(normalization,'dif_back_subs_blank')
    dif2_1=(cond2-cond1)./blank;
    dif3_4=(cond3-cond4)./blank;
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif2_1(:,:,i),clip);
        cellc1(:,:,:,i)=double2rgb(aux_1, gray);
    end
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif3_4(:,:,i),clip);
        cellc2(:,:,:,i)=double2rgb(aux_1, gray);
    end
    figure,montage(cellc1,gray),title('dif1 2 cocktail')
    figure,montage(cellc2,gray),title('dif3 4 cocktail')
end


if strcmp(normalization,'dif_back_subs_cock')
    dif2_1=(cond2-cond1)./cock;
    dif3_4=(cond3-cond4)./cock;
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif2_1(:,:,i),clip);
        cellc1(:,:,:,i)=double2rgb(aux_1, gray);
    end
    for i=1+pprest:tiempo
        [aux_1]=stdimage(dif3_4(:,:,i),clip);
        cellc2(:,:,:,i)=double2rgb(aux_1, gray);
    end
    figure,montage(cellc1,gray),title('dif1 2 cocktail')
    figure,montage(cellc2,gray),title('dif3 4 cocktail')
end

end




