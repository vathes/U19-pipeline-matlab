%{
-> meso.Scan
---
sync_frame        :    longblob   # frame number within tif file
sync_global       :    longblob   # global frame number in scan
sync_block        :    longblob   # behavioral block
sync_trial        :    longblob   # behavioral trial
sync_iteration    :    longblob   # register the sample number of behavior recording to each frame, some extra zeros in file 1, marking that the behavior recording hasn't started yet.                 
%}


classdef SyncImagingBehavior < dj.Computed
    
    % figure it out
end

