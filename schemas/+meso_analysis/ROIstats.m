%{
# statistics for ROI selection
-> meso.SegmentationRoi
-> meso.ROIstatsParamsSet
---
noise_level                : float       # noise levels of each ROI
positive_transients        : longblob    # 1 x num_frames boolean indicating significant positive transients
negative_transients        : longblob    # 1 x num_frames boolean indicating significant negative transients
trial_transient_count      : longblob    # 1 x num_trials transient count
mean_transients_per_trial  : float       # average number of transients per trial
mean_transients_per_on_trial  : float    # average number of transientspertrial in which the neuron actually fired
mean_transients_per_min    : float       # average number of transients per minute

%}


classdef ROIstats < dj.Computed
  methods(Access=protected)
    function makeTuples(self, key)
      
     
      self.insert(result)
    end
  end
end