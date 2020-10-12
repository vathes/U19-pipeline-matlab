%{
# General information of a session
-> subject.Subject
session_date                : date                          # date of experiment
session_number              : int                           # number
---
session_start_time          : datetime                      # start time
(session_location) -> lab.Location                          # Location where training is happening
local_path_behavior_file    : varchar(255)                  # Path were session file is stored in local computer
remote_path_behavior_file   : varchar(255)                  # Path were session file will be stored in bucket
%}

classdef SessionStarted < dj.Manual
end 
