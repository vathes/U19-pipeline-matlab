function insert_acq_session_started(acqsession_file, bucket_file_path, rig_default_path, subject)
%INSERT_ACQ_SESSION STARTED insert u19_acquisition.sessionstarted info when file is provided
%
% Input
% acqsession_file  = entire file path for towers task behavior file

local_default_path = 'C:/Data';

load(acqsession_file,'log')

%primary key values
key_session.subject_fullname = subject;
key_session.session_date = sprintf('%d-%02d-%02d', log.session.start(1), log.session.start(2), log.session.start(3));
key_session.session_number = 0;
key_session.remote_path_behavior_file = bucket_file_path;


key_session.session_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.start(1), log.session.start(2), log.session.start(3), log.session.start(4), log.session.start(5));
key_session.session_location = log.version.rig.rig;


% Get local path from bucket path and rig default path
local_path = strrep(bucket_file_path, rig_default_path, local_default_path);
local_path = fullfile(local_path);
local_path = strrep(local_path, '/', '\');

key_session.local_path_behavior_file  = local_path;


insert(acquisition.SessionStarted, key_session);



end

