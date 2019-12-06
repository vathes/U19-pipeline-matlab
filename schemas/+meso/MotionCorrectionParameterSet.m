%{
-> meso.MotionCorrectionMethod
parameter_set_id:     int          # parameter set id
---
max_shift : int  # maximal allowed frame shift in pxls, fileMCorr.params.maxShift
max_iter  : int  # maximal allowed iterations in correction algorithm, fileMCorr.paramts.maxIter
stop_below_shift: float    # threshold in pixels for stopping algorithm iterations, fileMCorr.params.stopBelowShift
interpolation:    float    # type of pixel interpolation (eg 'linear'), fileMCorr.params.interpolation
frame_skip: blob  # fileMCorr.Params.interpolation. The frameSkip parameter allows one to subsample the input movie in terms of frames. It should be provided as a pair [offset, skip] where offset is the first frames to skip, and skip is the number of frames to skip between reads. For example, frameSkip = [1 1] will start reading from the *second* frame and skip every other frame, i.e. read all even frames for motion correction. The produced shifts will thus be fewer than the full movie and equal to the number of subsampled frames.
%}

classdef MotionCorrectionParameterSet < dj.Lookup
 
end