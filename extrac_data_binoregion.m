%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ferret Exctract data%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
fid = fopen('exp.txt');
data = textscan(fid,'%s');
fclose(fid);
mouse=data{1,1}
clip=1.5;
variable=[];
c_areas=[];
i_areas=[];
datos{1}='filename';datos{2}='tot area';datos{3}='bino area'; datos{4}='contra area'
datos{5}='ipsi_area';datos{6}='bino_tot';datos{7}='contra_tot';datos{8}='ipsi_tot';
datos{9}='contra_resp';datos{10}='ipsi_resp';datos{11}='contra_resp_tot';datos{12}='ipsi_resp_tot';
datos{13}='Center of Mass'; datos{14}='RAW_bin_ODI'; datos{15}='filt_bin_ODI' ;
datos{16}='bin_equ_ODI' ;
datos{17}='RAW_ODI_all'; datos{18}='filt_all_ODI' ;
datos{19}='all_equ_ODI' 
for ii =1:length(mouse)


  cd(mouse{ii})
    load(mouse{ii})
  
    figure, imagesc(ipsi_area)
  contra_resp=sum(contra_area(:));
   ipsi_resp=sum(ipsi_area(:));
 
    tot_area=length(find(solap));
    bino_area=sum(sum(solap==1));
    contra_area=sum(sum(solap==2));
    ipsi_area=sum(sum(solap==-1));
datos{ii+1,1}=mouse{ii};
datos{ii+1,2}=tot_area;
datos{ii+1,3}=bino_area;
datos{ii+1,4}=contra_area;
datos{ii+1,5}= ipsi_area;
datos{ii+1,6}= bino_area/tot_area;
datos{ii+1,7}= contra_area/tot_area;
datos{ii+1,8}= ipsi_area/tot_area;
datos{ii+1,9}=contra_resp;
datos{ii+1,10}= ipsi_resp;
datos{ii+1,11}=contra_resp/tot_area;
datos{ii+1,12}= ipsi_resp/tot_area;
datos{ii+1,13}= CM_dist;
datos{ii+1,14}= nanmean(bin_RAW_ODI(:));
datos{ii+1,15}=nanmean(bin_filt_ODI(:));
datos{ii+1,16}= nanmean(bin_equ_ODI(:));
datos{ii+1,17}= nanmean(RAW_ODI(:));
datos{ii+1,18}=nanmean(filt_ODI(:));
datos{ii+1,19}= nanmean(equ_ODI(:));

% 
% 
% ODI.filt=filt_ODI;
% ODI.raw=equ_ODI;
% ODI.equ=RAW_ODI;
% 
% ODIbino.filt=bin_filt_ODI;
% ODIbino.raw=bin_equ_ODI;
% ODIbino.equ=bin_RAW_ODI;


cd('D:\scripts_mouse_analysis\analysis31032019')
end

