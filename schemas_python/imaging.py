import datajoint as dj
from . import subject, lab, task, acquisition

schema = dj.schema('pni_imaging')


@schema
class MotionCorrectionMethod(dj.Lookup):
    definition = """
    mcorr_method:           varchar(128)
    ---
    mcorr_function_name:    varchar(64)
    mcorr_code_hash:        varchar(64)
    """


@schema
class MotionCorrection(dj.Imported):
    definition = """
    -> acquisition.Scan
    ---
    x_shifts                        : longblob      # 512 x 512 x nFrames
    y_shifts                        : longblob      # 512 x 512 x nFrames
    reference_image                 : longblob      # 512 x 512
    motion_corrected_average_image  : longblob      # 512 x 512
    motion_corrected_movie          : longblob      # in summary.mat 1/10 down sampled
    """


@schema
class SegmentationMethod(dj.Lookup):
    definition = """
    method:    varchar(16)
    ---
    seg_function_name:    varchar(64)
    seg_function_hash:    varchar(64)
    """


@schema
class Segemention(dj.Imported):
    definition = """
    -> MotionCorrection
    -> SegmentationMethod
    ---
    frame_time:             longblob      # time of each frame, relative to session start
    segmentation_results:   longblob      # a picture of segmented result imported from morphology.mat
    """

    class Roi(dj.Part):
        definition = """
        -> master
        roi_idx:       int
        ---
        roi_mask:      longblob     # 512 x 512
        morphology:    enum('blob', 'donut', 'filament')
        """


class Trace(dj.Computed):
    definition = """
    -> Segmentation.Roi
    ---
    dff:   longblob     # delta f/f for each cell, 1 x nFrames
    """


class SyncImagingBehavior(dj.Computed):
    definition = """
    -> MotionCorrection
    ---
    frame_behavior_idx:    longblob   # register the sample number of behavior recording to each frame. 1 x nFrames
    frame_block_idx:       longblob   # register block number for each frame
    frame_trial_idx:       longblob   # register trial number for each frame
    """


class TrialTrace(dj.Computed):
    definition = """
    -> Segmentation.Roi
    -> acquistion.TowersBlock.Trial
    ---
    trial_diff:     longblob       # cut dff for each trial
    cue_range:      blob           # [start_idx, stop_idx]
    delay_range:    blob           # [start_idx, stop_idx]
    arm_range:      blob           # [start_idx, stop_idx]
    iti_range:      blob           # [start_idx, stop_idx]
    """
