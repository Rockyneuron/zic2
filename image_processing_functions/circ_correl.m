function[cr,sdcr,dr,rd]=circ_correl_OPM(Rmax,b,nsamples,disc,rd,ad)
%--------------------------------------------------------------------------
% This function calculates the circular correlation of the angles of an image
% inputs
% -im----------------------------------------Image pixels values [0,pi]
% -magfactor--------------------------------cortical mag factor
%-rdselec-----------------------starting points from where to calculate
%-adselec-----------------------respective orientations of rdselec
% Outputs
% -cr---------------------------------------Circular correl function
% -magfactor--------------------------------cortical mag factor
%-dr-----------------------binning
%-rd----------------------coordinates used for calculation

 display(['calculating circular correlation '])

%  if size(im,1) | size(im,2) ==1   
%      
%  else
% [rd,ad]=cor2im(im); %If the input is an image extract coordinates from image
%  end


dr = b;
cr = zeros(1,round(Rmax/dr));
sdcr = zeros(1,round(Rmax/dr));
id=0;
if nsamples>0  
y = datasample(1:length(rd),nsamples,'Replace',false);
rd_selec= rd(y,:);
else
%select all points
rd_selec= rd;
end


if disc==1
for r = [dr:b:Rmax]
    corr = [];
    [idx1, dist1] = rangesearch( rd, rd_selec, r-b/2);
    [idx2, dist2] = rangesearch(rd, rd_selec, r+b/2);
    if r==b && id==0
        %cojo las distancias del primer radio mayor
        for i = 1:length(idx1)
            if size(idx1{i},2)==1 %si el vecino mas proximo es si mismo paso al siguiente
                continue
            end
          nce = idx1{i}(idx1{i}~=i); % Find non common elements diferentes del propio dipolo
        for j = 1:length(nce)
                id = ceil(r/dr);
%                 corr(end+1) = cos(2*(im(rd_selec(i,1), rd_selec(i,2)) - ad(nce(j))));    
      corr(end+1) = cos(2*(ad(1,i) - ad(nce(j))));   

            end
        end
    cr(id) = mean(corr);
    sdcr(id) = std(corr)/sqrt(length(cr));
    end
    corr = [];
      
      id = find([dr:b:Rmax]==r)+1; %indice de donde va el valor de la correlacion en el vector, lo aumento una unidad para no sobreescribir
 display(['calculating circular correlation ' num2str((id/length(dr:b:Rmax))*100) '%done'])
   
                for i = 1:length(idx2)
        % setdiff(A,B) returns the data in A that is not in B.
        nce = setdiff(idx2{i}, idx1{i}); % Find non common elements
        for j = 1:length(nce)
%                  corr(end+1) = cos(2*(im(rd_selec(i,1), rd_selec(i,2)) - ad(nce(j))));      
      corr(end+1) = cos(2*(ad(1,i) - ad(nce(j))));   

        end
   
    end
    cr(id) = mean(corr);
    sdcr(id) = std(corr)/sqrt(length(cr));
 end
% figure, plot([[dr/2 dr:b:Rmax]./meassure],cr(1,:),'.')
% hold on
% plot(0:0.001:Rmax/meassure, zeros(1,length(0:0.001:Rmax/meassure)), 'b')
% xlabel('mm')
% ylabel('circ corre')
end
if disc==0
for r = [dr:b:Rmax]
    corr = [];
    [idx1, dist1] = rangesearch(rd, rd_selec, r-b/2);
    [idx2, dist2] = rangesearch(rd, rd_selec, r+b/2);
     id = find([dr:b:Rmax]==r);%indice de donde va el valor de la correlacion en el vector, lo aumento una unidad para no sobreescribir
display([ '=' num2str((id/length(dr:b:Rmax))*100) '% done'])
                for i = 1:length(idx2)
        % setdiff(A,B) returns the data in A that is not in B.
%         nce = setdiff(idx2{i}, idx1{i}); % Find non common elements
% 
%         nce = setdiff(idx2{i}, idx1{i}); % Find non common elements
        nce = idx2{i}(~ismember(idx2{i}, idx1{i})); % Find non common elements

%         nce = idx2{i}.*(~ismember(idx2{i}, idx1{i})); % Find non common elements
%             nce=nce(find(nce)); 
        for j = 1:length(nce)
%                 corr(end+1) = cos(2*(im(rd_selec(i,1), rd_selec(i,2)) - ad(nce(j))));   
      corr(end+1) = cos(2*(ad(1,i) - ad(nce(j))));   


        end
   
    end
    cr(id) = mean(corr);
    sdcr(id) = std(corr)/sqrt(length(cr));
%     sdcr(id) = std(bootci(1000,@mean,corr));

% sdcr(1:2,id) = bootci(100,@mean,corr);

end
end
