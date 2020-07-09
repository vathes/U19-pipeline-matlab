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
      
     %% fetch and define some extra pars
     [minActiveSecs, minDFF]   = fetchn(meso_analysis.ROIstatsParamsSet & key, 'min_active_seconds', 'min_dff');
     frameRate       = fetch1(meso.ScanInfo & key, 'frame_rate'); 
     deltaT          = 1/frameRate;
     minActiveImg    = ceil(minActiveSecs / deltaT);
     rebinFactor     = round(fetch1(meso.SegParameterSetParameter, 'cnmf_time_resolution') / (1000/frameRate)); %before it was ceil
     
      %% get DFF and a bunch of other keys
      %%%%%%%%%%%%%%%%%need to also load delta from here!!!!!
      [dff, selectedROI, isSignificant]  = fetchn(meso.Trace & key,                  ...
                              'dff_roi','roi_idx', 'dff_roi_is_significant');
      dff                   = cell2mat(dff); % neurons by frames 
      
      %% select and sort ROIs
      goodMorphoOnly = fetch1(meso_analysis.ROIstatsParamsSet & key, 'good_morpho_only');
      if goodMorphoOnly == 1
        morpho               = fetchn(meso.SegmentationRoiMorphologyManual & key, 'morphology');
      else
        morpho               = [];
      end
      
      if isempty(morpho)
        isgood               = true(1,size(dff,1));
      else
        isgood               = strcmp(morpho,'Doughnut') | strcmp(morpho,'Blob');
      end
      isallnan               = sum(isnan(dff),2) == size(dff,2);
      isgood                 = isgood & ~isallnan;
      
      dff(~isgood,:)         = [];
      selectedROI(~isgood,:)  = [];
      
%        activeCount       = cellfun ( @(x) sum( cnmf(iAcquis).isSignificant(selectedROI,x)              ...
%                                           & cnmf(iAcquis).delta(selectedROI,x) > cfg.minDFF         ...
%                                           , 2 )                                                     ...
%                                 , {acquisTrial.frame}, 'UniformOutput', false                       ...
%                                 );
      
       
    %% paths and session info
%     [subject, sessionDate] = fetch1(meso.ScanInfo & key, 'subject_fullname','session_date');
%     
%     ROI_dirs               = fetchn(meso.FieldOfView & key, 'fov_directory');
%     tifName                = fetchn(meso.FieldOfViewFile & key      ...
%                              & struct('session_number', 0, 'file_number', 1), 'fov_filename'); 
%     
%     inputPrefix = cell(length(tifName) ,1);
%     for iROI = 1:length(ROI_dirs)
%        ROI_dirs{iROI}      = formatFilePath(ROI_dirs{iROI}, false, true);
%        tf                  = strsplit(tifName{iROI}, '_');
%        inputPrefix{iROI}   = [ROI_dirs{iROI}, strjoin(tf(1:end-1), '_')];
%     end
    
%%     
      self.insert(result)
    end
  end
end