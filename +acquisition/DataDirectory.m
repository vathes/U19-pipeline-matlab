%{
-> acquisition.Session
-----
data_dir:  varchar(255) # data directory for each session
file_name: varchar(255) # file name
combined_file_name: varchar(255) # combined filename
%}

classdef DataDirectory < dj.Computed
    
    properties
        popRel = acquisition.Session & 'location != "wide-field"'
    end

	methods(Access=protected)

		function makeTuples(self, key)
            
            base_dir = '/Volumes/braininit/RigData/training/';
            [user, rig, subject, session_date] = fetch1(...
                acquisition.Session & key, 'user_id', 'location', 'subject_id', 'session_date');
            session_date = erase(session_date, '-');
            rig_number = rig(regexp(rig, '[0-9]'));
            file = dir([base_dir 'rig' rig_number '/' user '/*/data/' subject '/*_' session_date '.mat']);
            
            if isempty(file)
                return
            end
            key.data_dir = file.folder;
            key.file_name = file.name;
            key.combined_file_name = [file.folder '/' file.name];
            
			self.insert(key)
		end
	end

end