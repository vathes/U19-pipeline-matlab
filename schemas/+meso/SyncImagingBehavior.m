%{
-> meso.Scan
---
frame_behavior_idx:    longblob   # register the sample number of behavior recording to each frame, some extra zeros in file 1, marking that the behavior recording hasn't started yet.                                  #1 x nFrames, metadata-imaging-iteration
frame_block_idx:       longblob   # register block number for each frame, metadata-imaging-block
frame_trial_idx:       longblob   # register trial number for each frame, metadata-imaging-trial
%}


classdef SyncImagingBehavior < dj.Manual
end
