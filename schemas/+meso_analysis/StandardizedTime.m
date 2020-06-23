%{
# time binned activity by trialStruct
-> meso.Segmentation
---

standardized_time : blob  # linearly interpolated behavioral epoch ID per imaging frame

%}



classdef StandardizedTime < dj.Computed
  methods(Access=protected)
    function makeTuples(self, key)
      % event.epoch 
      
      % see getBehaviorPlusImaging_mesoscope
%       %% Relative durations
% 
%       fEpoch          = [ trialStruct(iTrial).fTrialStart, trialStruct(iTrial).fCueEntry, trialStruct(iTrial).fMemEntry, trialStruct(iTrial).fArmEntry, trialStruct(iTrial).fTrialEnd ];
%       if trialStruct(iTrial).choice ~= trialStruct(iTrial).trialType
%         fEpoch(end+1) = trialStruct(iTrial).fErrorITI;
%       end
%       fEpoch(end+1) = trialStruct(iTrial).fITIEnd + 1;
%       fEpoch        = cummax(fEpoch);
%       event(iAcquis).epoch(trialStruct(iTrial).frame)     ...
%                     = standardizedLocation(fEpoch);
%                   
%   fEpoch              = fEpoch - fEpoch(1) + 1;               % start output at 1
%   location            = nan(fEpoch(end) - 1,1);
%   for iEpoch = 1:numel(fEpoch) - 1
%     tRange            = fEpoch(iEpoch):fEpoch(iEpoch + 1) - 1;
%     loc               = linspace(0, 1, numel(tRange)+1);
%     location(tRange)  = iEpoch-1 + loc(1:end-1);
%   end
    end
  end
end

