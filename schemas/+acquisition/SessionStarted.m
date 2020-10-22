%{
# General information of a session
-> subject.Subject
session_date                : date                          # date of experiment
session_number              : int                           # number
---
session_start_time          : datetime                      # start time
(session_location) -> lab.Location                          # Location where training is happening
-> task.Task                                                # Which task was performed in session
local_path_behavior_file    : varchar(255)                  # Path were session file is stored in local computer
remote_path_behavior_file   : varchar(255)                  # Path were session file will be stored in bucket
is_finished=0               : boolean                       # Flag that indicates if this session was finished successfully
%}

classdef SessionStarted < dj.Manual
    
    
    methods
        function insertSessionStartedFromFile_Towers(self,key,log, bucket_file_path)
            % Insert sessionStarted record from towers task behavioralfile
            % Called at the end of training or when populating session
            % Input
            % self             = acquisition.SessionStarted instance
            % key              = structure with required fields: (subject_fullname, date, session_no)
            % log              = behavioral file as stored in Virmen
            % bucket_file_path = 
            
            %INSERT_ACQ_SESSION STARTED insert u19_acquisition.sessionstarted info when file is provided
            %
            % Input
            % acqsession_file  = entire file path for towers task behavior file
            
            local_default_path = 'C:/Data';
            
            %primary key values
            key.remote_path_behavior_file = bucket_file_path;
            
            
            key.session_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.start(1), log.session.start(2), log.session.start(3), log.session.start(4), log.session.start(5));
            key.session_location = log.version.rig.rig;
            key.task = 'Towers';
            
            % Get local path from bucket path and rig default path
            local_path = strrep(bucket_file_path, rig_default_path, local_default_path);
            local_path = fullfile(local_path);
            local_path = strrep(local_path, '/', '\');
            
            key.local_path_behavior_file  = local_path;
            
            %By default, we think this task was successfully finished
            key.is_finished = 1;
            
            
            insert(acquisition.SessionStarted, key);
            
            
        end
        
    end
    
end
