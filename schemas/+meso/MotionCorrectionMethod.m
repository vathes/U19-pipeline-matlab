
%{
# available motion correction method
mcorr_method:           varchar(128)
%}

    
 classdef MotionCorrectionMethod < dj.Lookup
     properties
        contents = {'cv.motionCorrect'};
     end
 end