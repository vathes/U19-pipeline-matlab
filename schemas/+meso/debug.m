%{
# activity traces for each ROI
sess_idx               : int 
roi_idx                : int
---
dff_roi                : blob@mesoimaging  # delta f/f for each cell, 1 x nFrames. In case of chunks in segmentation, frames with no data are filled with NaN
dff_roi_is_significant : blob@mesoimaging  # same size as dff_roi, true where transitents are significant
dff_roi_is_baseline    : blob@mesoimaging  # same size as dff_roi, true where values correspond to baseline
dff_surround           : blob@mesoimaging  # delta f/f for the surrounding neuropil ring
spiking                : blob@mesoimaging  # recovered firing rate of the trace
time_constants         : blob              # 2 floats per roi, estimated calcium kernel time constants
init_concentration     : float             # estimated initial calcium concentration for estimated kernel
%}


classdef Trace < dj.Imported
  methods(Access=protected)
    function makeTuples(self, key)
      
      %% write ROI-specific info into relevant tables
      load  /jukebox/braininit/RigData/mesoscope/imaging/dj_debug/LP_dj_debug_data.mat
      totalFrames = 55000;
      chunkRange  = [8001 26000];
      iChunk      = 1;
      sess_idx    = 1;
      
      % loop through ROIs
      for iROI = 1:nROIs
        
        trace_data.sess_idx                 = sess_idx; 
        trace_data.roi_idx                  = iROI;  

        trace_data.time_constants           = data.cnmf.timeConstants{iROI};
        trace_data.init_concentration       = data.cnmf.initConcentration{iROI};
        trace_data.dff_roi                  = nan(1,totalFrames);
        trace_data.dff_surround             = nan(1,totalFrames);
        trace_data.spiking                  = nan(1,totalFrames);
        trace_data.dff_roi_is_significant   = nan(1,totalFrames);
        trace_data.dff_roi_is_baseline      = nan(1,totalFrames);

        % activity traces
        frameIdx                                    = chunkRange(iChunk,1):chunkRange(iChunk,2);
        trace_data.dff_roi(frameIdx)                = data.cnmf.dataDFF(iROI,:);
        trace_data.dff_surround(frameIdx)           = data.cnmf.dataBkg(iROI,:);
        trace_data.spiking(frameIdx)                = data.cnmf.dataDFF(iROI,:);
        trace_data.dff_roi_is_significant(frameIdx) = data.cnmf.isSignificant(iROI,:);
        trace_data.dff_roi_is_baseline(frameIdx)    = data.cnmf.isBaseline(iROI,:);

        self.insert(trace_data)
      end
      
    end
  end
end
