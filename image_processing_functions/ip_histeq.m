function[out]=ip_histeq(im,L,h)


if ~exist('L','var')
    L=256
end
if ~exist('h','var')
    h=imhist(im,L)/numel(im);
end
%  load ('cdf_fit_kas');
cdf=cumsum(h);
cdf_fit=fit(linspace(0,1,L)',cdf,'line');

out=reshape(cdf_fit(reshape(im,[1,numel(im)])),size(im)); 
 figure, plot(linspace(0,1,length(cdf))',cdf),
hold on
 plot(cdf_fit)
 figure, plot(linspace(0,1,length(cdf))',h),

%+1 por que matlab empieza por uno y las 
%imagenes tienen valores de intensidad =0
out=mat2gray(out);
 hout=imhist(out,L)/numel(out);
 cdfout=cumsum(hout);

% 

% figure, 
% subplot(2,3,1),imagesc(im), title('input'), axis image, colormap gray
% subplot(2,3,2),imhist(im), title('pdf')
% subplot(2,3,3),plot(linspace(0,1,length(cdf)),cdf), title('cdf')
% subplot(2,3,4),imagesc(out), title('output'), axis image, colormap gray
% subplot(2,3,5),imhist(out), title('pdf')
% subplot(2,3,6),plot(linspace(0,1,length(cdfout)),cdfout), title('cdf') ,title('ouput')

% % 
% % figure, 
% % subplot(2,3,1),imagesc(im), title('input'), axis image, colormap gray
% % subplot(2,3,2),plot(h), title('pdf')
% % subplot(2,3,3),plot(linspace(0,1,length(cdf)),cdf), title('cdf')
% % subplot(2,3,4),imagesc(out), title('output'), axis image, colormap gray
% % subplot(2,3,5),imhist(out), title('pdf')
% % subplot(2,3,6),plot(linspace(0,1,length(cdfout)),cdfout), title('cdf') ,title('ouput')
% % 
% 
%  him=imhist(im,L)/numel(im);
% figure, 
% plot(linspace(0,1,L),him,'.')
% hold on
% plot(linspace(0,1,L),h,'.')
% hold on
% plot(linspace(0,1,L),hout,'.')
% 
% legend('input', 'fit pdf', 'output')
% 
% figure, plot(im(:)',out(:)','.'), xlabel('input'), ylabel('output')
% 









end