%{
-> meso.FieldOfView
-> meso.MotionCorrectionParameterSet       # meta file, frameMCorr-method
---
%}


classdef MotionCorrection < dj.Imported
    methods
        function makeTuple(self, key)
            
            % call functions to compute motioncorrectionWithinFile and
            % AcrossFiles and insert into the tables
            % insert an entry into this table as well, just the key
        end
    end

end