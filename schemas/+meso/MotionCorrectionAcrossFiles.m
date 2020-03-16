%{
-> meso.FieldOfView
-> meso.MotionCorrectionParameterSet       # meta file, frameMCorr-method
---
cross_files_x_shifts                        : longblob      # nFrames x 2, meta file, fileMCorr-xShifts
cross_files_y_shifts                        : longblob      # nFrames x 2, meta file, fileMCorr-yShifts
cross_files_reference_image                 : longblob      # 512 x 512, meta file, fileMCorr-reference
%}


classdef MotionCorrectionAcrossFiles < dj.Imported
    % ingested by meso.MotionCorrection
end