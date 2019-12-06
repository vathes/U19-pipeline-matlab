%{
-> meso.FieldOfViewFile
-> meso.MotionCorrectionMethod       # meta file, frameMCorr-method
---
x_shifts                        : longblob      # nFrames x 2, meta file, frameMCorr-xShifts
y_shifts                        : longblob      # nFrames x 2, meta file, frameMCorr-yShifts
reference_image                 : longblob      # 512 x 512, meta file, frameMCorr-reference
%}


classdef MotionCorrectionWithinFile < dj.Imported

end