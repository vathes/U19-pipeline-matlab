%{
-> meso.McParameterSet
-> meso.McParameter
---
mc_max_shift         : blob     # max allowed shift in pixels
mc_max_iter          : blob     # max number of iterations
mc_stop_below_shift  : float    # tolerance for stopping algorithm
mc_black_tolerance   : float    # tolerance for black pixel value
mc_median_rebin      : float    # ? (check with Sue Ann)
%}

classdef McParameterSetParameter < dj.Part
  properties(SetAccess=protected)
    master   = meso.McParameterSet
    contents = {
               15, 5, 0.3, nan, 10
               }
  end
end
