%{
# time binned activity by trial
-> meso.Segmentation
-> meso_analysis.BinningParameters
global_roi_idx         : int   # roi_idx in SegmentationRoi table
trial_idx              : int   # virmen trialStruct number
---

binned_dff             : blob  # binned Dff, 1 row per neuron per trialStruct

%}


classdef BinnedTrace < dj.Computed
  methods(Access=protected)
    function makeTuples(self, key)
      
      if ~isstruct(key)
        result = fetch(key);
      else
        result = key;
      end
      
      %% retrieve dff data
      [dff,global_idx] = fetchn(meso.Trace & key, 'dff_roi','roi_idx');
      dff              = cell2mat(dff); % neurons by frames 
      
      %% use manual curation to select only good rois
      goodMorphoOnly = fetch1(meso_analysis.BinningParameters & key, 'good_morpho_only');
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
      global_idx(~isgood,:)  = [];
      
      %% get behavioral trial info
      standardizedTime = fetch(meso_analysis.StandardizedTime & key, 'standardized_time');
      
      syncinfo = fetch(meso.SyncImagingBehavior & key, 'sync_im_frame', 'sync_im_frame_global','sync_behav_block_by_im_frame', 'sync_behav_block_by_im_frame', ...
        'sync_behav_trial_by_im_frame', 'sync_behav_iter_by_im_frame', 'sync_im_frame_span_by_behav_block','sync_im_frame_span_by_behav_trial','sync_im_frame_span_by_behav_iter');
      % get num_frames_per_trial
      % trial_idx
      
      %% get epoch bins
      epochEdges  = getEpochEdges(key);
      
      %% loop through ROIs and trials and bin                  
      for iROI = 1:size(dff,1)          
        thisresult                = result;
        thisresult.global_roi_idx = global_idx(iROI);
        
        % bin in nested function
        epochDFF     = bin_trial(dff(iROI,:), epochEdges, trial_idx, standardizedTime, num_frames_per_trial); % bins x trials 

        for iTrial = 1:numel(trial_idx)
          thisresult.trial_idx  = trial_idx(iTrial);
          thisresult.binned_dff = epochDFF(:,iTrial);
          self.insert(thisresult)
        end
      end

    end
  end
end


% =======================================================================
function epochEdges = getEpochEdges(key)
  epochBinning = fetch1(meso_analysis.BinningParameters & key, 'epoch_binning');
  epochEdges   = accumfun(2, @(x,y,z) butlast(linspace(x,y,z)), ...
                             0:numel(epochBinning)-1, 1:numel(epochBinning), epochBinning);
end

% =======================================================================
% SUE ANNS averageInBin function, renamed 
% Average data into bins as specified by the bin index.
%
% bin should be an n-by-m matrix where n = size(data,dim) and m = numel(numBins). Each of the m
% columns of bin is assumed to be one indexing dimension. The output will thus replace the dim
% dimension of data with an m-dimensional binned aggregate.
function average = bin_trial(data, epochEdges, trial_idx, standardizedTime, num_frames_per_trial)
  
  
  dim = 1; % dimension along which to bin
  
  %%
  valid_frames = ~isnan(data);
  epoch        = standardizedTime(valid_frames);
  epochBin     = binarySearch(epochEdges, epoch, -1, -1);
  dataTrial    = accumfun(1, @(x,y) repmat(x,y,1), 1:numel(trial_idx), num_frames_per_trial);
  dataBins     = [epochBin(:), dataTrial(:)];
  numBins      = [numel(epochEdges), numel(trial_idx)];
  
  %% Reshape data so that the desired dimension to aggregate is in a canonical location
  dataSize            = size(data);
  data                = reshape(data, prod(dataSize(1:dim-1)), [], prod(dataSize(dim+1:end)));
  
  %% Compute linearized index for all columns of bin
  dimFactor           = cumprod(numBins(1:end-1));
  dimFactor           = [1, dimFactor(:)'];
  globalBin           = 1 + sum(bsxfun(@times, dataBins-1, dimFactor), 2);
  
  %% Compute aggregate along the desired dimension
  lastIndex           = prod(numBins);
  hasInfo             = ~isnan(data);
  addData             = data;
  addData(~hasInfo)   = 0;
  average             = zeros([size(data,1), lastIndex, size(data,3)]);
  count               = zeros([size(data,1), lastIndex, size(data,3)]);
  for iData = 1:numel(globalBin)
    average(:,globalBin(iData),:)     ...
                      = average(:,globalBin(iData),:) + addData(:,iData,:);
    count(:,globalBin(iData),:)     ...
                      = count(:,globalBin(iData),:) + hasInfo(:,iData,:);
  end
  average             = average ./ count;
  
  %% Reshape output to match input dimensions, except with dim replaced by numBins
  average             = reshape(average, [dataSize(1:dim-1), numBins, dataSize(dim+1:end)]);
  
end