%{
-> meso.MotionCorrectionMethod
mc_parameter_set_id:   int    # parameter set id
%}

classdef McParameterSet < dj.Lookup
  properties
    contents = { 1 }
  end
end

% manually insert into these tables: MotionCorrectionMethod, McParameter, McParameterSet,
% McParameterSetParameter once