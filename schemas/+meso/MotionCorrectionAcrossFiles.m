%{
-> meso.FieldOfView
-> meso.McParameterSet       # meta file, frameMCorr-method
---
cross_files_x_shifts           : longblob@mesoimaging      # nFrames x 2, meta file, fileMCorr-xShifts
cross_files_y_shifts           : longblob@mesoimaging      # nFrames x 2, meta file, fileMCorr-yShifts
cross_files_reference_image    : longblob@mesoimaging      # 512 x 512, meta file, fileMCorr-reference
%}


classdef MotionCorrectionAcrossFiles < dj.Imported
  % ingested by meso.MotionCorrection
  methods(Access=protected)
    function makeTuples(self, key)
      self.insert(key)
    end
  end
end