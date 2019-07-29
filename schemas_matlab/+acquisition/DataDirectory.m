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

            [user, rig, subject, session_date] = fetch1(...
                acquisition.Session & key, 'user_id', 'location', 'subject_id', 'session_date');
            session_date = erase(session_date, '-');  

            if strcmp('Bezos3', rig)
                % Or on the scope in bezos
                base_dir = '/Volumes/braininit/RigData/scope/bay3/';
            	file = dir([base_dir '/' user '/*/data/' subject '/*_' session_date '.mat']);
            else
                % Training rigs 1 to 7
                rig_number = rig(regexp(rig, '[0-9]'));
                base_dir = '/Volumes/braininit/RigData/training/';
                if strcmp(subject, 'E86')
                    subject = 'e86';
                end
            	file = dir([base_dir 'rig' rig_number '/' user '/*/data/' subject '/*_' session_date '.mat']);
            end
            if strcmp('VRLaser', rig)
                base_dir = '/Volumes/braininit/RigData/VRLaser/behav/lucas/blocksReboot/data';
                file = dir([base_dir '/' subject '/*_' session_date '.mat']);
            end
            
            if isempty(file)
                disp([rig, '  -file not found.'])
                return
            end
            key.data_dir = file.folder;
            key.file_name = file.name;
            key.combined_file_name = [file.folder '/' file.name];
            
			self.insert(key)
		end
	end

end