
function[tms]=sig_timecourse(I,roi)
%------------------------------------------------------------------------
%  This function calculates de mean and std of each frame
%  Input:
%  I.............................................Image(3D matrix)
%  roi...........................................region of intereset used
%
%-------------------------------------------------------------------------

roi(roi==0)=nan;
signal=I.*repmat(roi,[1,1,20]);
tms=[nanmean(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1);
nanstd(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1)];
%figure,montage(double2rgb(signal,gray),gray),title('single condition 1 blank')

end
