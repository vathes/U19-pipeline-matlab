%{
% table that reflects the contents in the file recInfo.mat
-> meso.Scan
---
file_name_base    : varchar(255)  # base name of the file ("FileName")
scan_width        : int           # width of scanning in pixels ("Width")
scan_height       : int           # height of scanning in pixels ("Height")
acq_time          : datetime      # acquisition time ("AcqTime")
n_depths          : tinyint       # number of depths ("nDepths")
scan_depths       : tinyint       # depths in this scan ("Zs")
frame_rate        : float         # ("frameRate")
inter_fov_lag_sec : float         # time lag in secs between fovs ("interROIlag_sec")
frame_ts_sec      : longblob      # frame timestamps in secs 1xnFrames ("Timing.Frame_ts_sec")
power_percent     : float         # percentage of power used in this scan ("Scope.Power_percent")
channels          : blob          # ----is this the channer number or total number of channels? ("Scope.Channels")
cfg_filename      : varchar(255)  # cfg file path ("Scope.cfgFilename")
usr_filename      : varchar(255)  # usr file path ("Scope.usrFilename")
fast_z_lag        : float         # fast z lag ("Scope.fastZ_lag")
fast_z_flyback_time: float        # ("Scope.fastZ_flybackTime")
line_period       : float         # scan time per line ("Scope.linePeriod")
scan_frame_period : float         # ("Scope.scanFramePeriod")
scan_volume_rate  : float         # ("Scope.scanVolumeRate")
flyback_time_per_frame: float     # ("Scope.flybackTimePerFrame")
flyto_time_per_scan_field: float  # ("Scope.flytoTimePerScanfield")
fov_corner_points : blob          # coordinates of the corners of the full 5mm FOV, in microns ("Scope.fovCornerPoints")
nfovs             : int           # number of field of view
nframes           : int           # number of frames in the scan
%}


classdef ScanInfo < dj.Imported
    
    methods
        function makeTuples(self, key)
            % ingestion triggered by the existence of Scan
            % will run a modified version of mesoscopeSetPreproc
            % will also trigger the ingestion into the table FieldOfView
        end
    end
end
