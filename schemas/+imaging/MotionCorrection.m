%{
-> imaging.ScanFile
-> imaging.MotionCorrectionMethod       # meta file, frameMCorr-method
---
x_shifts                        : longblob      # nFrames x 2, meta file, frameMCorr-xShifts
y_shifts                        : longblob      # nFrames x 2, meta file, frameMCorr-yShifts
reference_image                 : longblob      # 512 x 512, meta file, frameMCorr-reference
motion_corrected_average_image  : longblob      # 512 x 512, meta file, activity
mcorr_metric                    : varchar(64)   # frameMCorr-metric-name
%}

classdef MotionCorrection < dj.Imported
end