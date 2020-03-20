%{
% A mesoscope scanning session
-> acquisition.Session
---
scan_directory       : varchar(255)
gdd=null             : float
wavelength=940       : float                        # in nm
pmt_gain=null        : float
-> [nullable] reference.BrainArea.proj(imaging_area="brain_area")
%}


classdef Scan < dj.Imported
  methods(Access=protected)
    
    function makeTuples(self, key)
      
      % find subject and date from acquisition.Session table
      [subj, session_date] = fetch1(subject.Subject * acquisition.Session & key, ...
                                         'subject_nickname', 'session_date');
      session_date         = erase(session_date, '-');
      base_dir             = '/braininit/RigData/mesoscope/imaging/';
      folder_path          = [base_dir subj '/' session_date];
      if isempty(dir(folder_path))
        fprintf('directory %s not found\n',folder_path)
        return
      end
      
      % write full directory where raw tifs are
      key.scan_directory   = getLocalPath(folder_path, 'global');   
      
      self.insert(key)
      
    end
  end
end
