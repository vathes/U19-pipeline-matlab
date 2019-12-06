%{
# available segmentation methods
-> meso.SegmentationMethod
seg_parameter_set_id: int   # parameter set of a method
---
cfg_k                      : int
cfg_tau                    : float
cfg_p                      : float
cfg_interations            : int
cfg_zeros_is_minimum       : boolean
cfg_default_time_scale     : float
cfg_time_resolution        : float
cfg_dff_rectification      : float
cfg_frame_rate             : float
cfg_min_num_frames         : int
cfg_min_roi_significance   : float
cfg_max_centroid_distance  : float
cfg_min_distance_pixels    : float
cfg_min_shape_corr         : float
cfg_pixels_surround        : blob
proto_cfg_hi_tail_prob     : blob 
proto_cfg_tail_prob_cap    : float
proto_cfg_tail_occupancy   : float
proto_cfg_min_region_n_pix : int
proto_cfg_max_sub_lobe_n_pix: int
proto_cfg_punctal_n_pix    : int
proto_cfg_background_scale : float
proto_cfg_puncta_radius    : float
proto_cfg_soma_radius      : float
proto_cfg_max_eccentricity : float
proto_cfg_spatial_smooth   : boolean
proto_cfg_high_significance: float
proto_cfg_med_significance : float
proto_cfg_min_significance : float
proto_cfg_sig_rectification: blob
proto_cfg_shape_quantile   : float
proto_cfg_factors_above_bkg: int
proto_cfg_min_frame_corr   : float
proto_cfg_signal_rebin     : float
proto_cfg_baseline_bins    : int
proto_cfg_min_signi_voxels : int
proto_cfg_merged_signi_voxels: int
proto_cfg_min_resolve_frames: int
proto_cfg_signal_max_corr  : float
proto_cfg_ident_min_corr   : float
proto_cfg_merge_min_corr   : float
proto_cfg_ambiguous_min_corr: float
proto_cfg_absorb_min_corr  : float
proto_cfg_max_corr_lag     : int
proto_cfg_min_sub_compartment: float
proto_cfg_greedy_merge_n_comp: int 
proto_cfg_baseline_fudge   : boolean
proto_cfg_max_contiguous_pix: int 
proto_cfg_min_contiguous_pix: int
%}

classdef SegmentationParameterSet < dj.Lookup
    properties
        % list the current parameters here: contents = {1, ...};
    end
end