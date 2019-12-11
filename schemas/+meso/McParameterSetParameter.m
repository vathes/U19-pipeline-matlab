%{
-> meso.McParameterSet
-> meso.McParameter
---
mc_parameter_value: blob   # value of parameter
%}

classdef McParameterSetParameter < dj.Part
    properties(SetAccess=protected)
        master = meso.McParameterSet
    end
end