close all
clear all



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
datos{19}='all_eqODI'; datos{20}='contra_blk';datos{21}='ipsi_blk' 
datos{22}='frames';datos{23}='pprest';datos{24}='alfa';
datos{25}='clip'; datos{26}='normalization';datos{27}='thr';
datos{28}='exp_loc',datos{29}='SNR_contra',datos{30}='SNR_ipsi'
cd analysed
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
datos{ii+1,20}= exp{1};
datos{ii+1,21}= exp{2};
datos{ii+1,22}= frame;
datos{ii+1,23}= pprest;
datos{ii+1,24}= alfa;
datos{ii+1,25}= clip;
datos{ii+1,26}= normalization;
datos{ii+1,27}=thr
datos{ii+1,28}=file_store
datos{ii+1,29}=SNR.contra
datos{ii+1,30}=SNR.ipsi

% 
% 
% ODI.filt=filt_ODI;
% ODI.raw=equ_ODI;
% ODI.equ=RAW_ODI;
% 
% ODIbino.filt=bin_filt_ODI;
% ODIbino.raw=bin_equ_ODI;
% ODIbino.equ=bin_RAW_ODI;


cd('..')
end
writecell(datos,'preliminar.xlsx')


