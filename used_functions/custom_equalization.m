function[C1,C2,C3,C4]=custom_equalization(RC1,RC2,RC3,RC4)


      
  m1=0.5, sig1=0.15, A1=1, K=0, bin=numel(RC1);
 hgram = linspace(0,1,numel(RC1));
    
     [p ,z]= custom_hist(m1, sig1, A1,K,bin);
  figure, 
  plot(z,p,'.')
    
     c1teq=histeq(RC1,p);
    c2teq=histeq(RC2,p);
    c3teq=histeq(RC3,p);
    c4teq=histeq(RC4,p);


    figure,
    subplot(2,4,1),imagesc(c1teq), colormap gray, axis image
    subplot(2,4,2),imhist(c1teq)
    subplot(2,4,3),imagesc(c2teq), colormap gray, axis image
    subplot(2,4,4),imhist(c2teq)
    subplot(2,4,5),imagesc(c3teq), colormap gray, axis image
    subplot(2,4,6),imhist(c3teq)
    subplot(2,4,7),imagesc(c4teq), colormap gray, axis image
    subplot(2,4,8),imhist(c4teq)
    
    
    C1=c1teq;
    C2=c2teq;
    C3=c3teq;
    C4=c4teq;
 


end