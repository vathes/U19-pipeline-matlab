%{
# parameter values of a segmentation parameter set
-> meso.SegParameterSet
-> meso.SegParameter
---
seg_parameter_value:   blob   # parameter value
%}

classdef SegParameterSetParameter < dj.Part
    properties(SetAccess=protected)
        master = meso.SegParameterSet
    end
end