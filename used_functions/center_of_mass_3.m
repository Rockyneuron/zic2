function[out]=center_of_mass_3(A)

tot_mass = nansum(A(:));
[ii,jj] = ndgrid(1:size(A,1),1:size(A,2));
R = nansum(ii(:).*A(:))/tot_mass;
C = nansum(jj(:).*A(:))/tot_mass;
out = [tot_mass,round(R,3),round(C,3)]




end