%{
-> meso.FieldOfView
-> meso.MotionCorrectionParameterSet       # meta file, frameMCorr-method
---
%}


classdef MotionCorrection < dj.Imported
  methods
    function makeTuple(self, key)
      
      % path
      fov_directory = fetch1(key,'fov_directory');
      
      %%%%%%%%%% analysis parameters
      
      % call functions to compute motioncorrectionWithinFile and
      % AcrossFiles and insert into the tables
      fprintf('==[ PROCESSING ]==   %s\n', fov_directory);
  
      % Determine whether or not we need to use frame skipping to select only the first channel
%       movieFiles                    = dir(sprintf('%s*.tif',fov_directory));
      [order,movieFiles]            = fetchn(meso.FieldOfViewFile & key, 'file_number', 'fov_file_name');
      movieFiles                    = movieFiles(order);
      info                          = cv.imfinfox(movieFiles{1}, true);
      if numel(info.channels) > 1
        cfg.mcorr{end+1}            = [0, numel(info.channels)-1];
      end
      
      % run motion correction
      [frameMCorr, fileMCorr]       = getMotionCorrection(movieFiles, false, 'off', cfg.mcorr{:});

      
      % insert an entry into this table as well, just the key
      self.insert(key)
      
      % insert within file correction meso.motioncorrectionWithinFile
      within_key = struct('FieldOfViewFile','','MotionCorrectionParameterSet',[],...
                          'within_file_x_shifts',[],'within_file_y_shifts',[],'within_reference_image',[]);
                        
      for iFile = 1:numel(frameMCorr)
        within_key(iFile).FieldOfViewFile               = movieFiles{iFile};
        within_key(iFile).MotionCorrectionParameterSet  = key.MotionCorrectionParameterSet;
        within_key(iFile).within_file_x_shifts          = frameMCorr(iFile).xShifts;
        within_key(iFile).within_file_y_shifts          = frameMCorr(iFile).yShifts;
        within_key(iFile).within_reference_image        = frameMCorr(iFile).reference; 
      end
      
      insertn(meso.motioncorrectionWithinFile, within_key)
      
      % insert within file correction meso.motioncorrectionAcrossFile
      across_key.FieldOfView                   = key.FieldOfView;
      across_key.MotionCorrectionParameterSet  = key.MotionCorrectionParameterSet;
      across_key(iFile).within_file_x_shifts   = fileMCorr(iFile).xShifts;
      across_key(iFile).within_file_y_shifts   = fileMCorr(iFile).yShifts;
      across_key(iFile).within_reference_image = fileMCorr(iFile).reference; 
        
      insert1(meso.motioncorrectionAcrossFile, across_key)
      
    end
  end
  
end

% if nonlinMotionCorr
%     cfg.mcorr                   = {[15 15], [5 2], 0.3, 10};
%   else
%     cfg.mcorr                   = {15, 5, false, 0.3, nan, 10};
%   end