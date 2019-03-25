%{
-> subject.Subject
session_date:               date        # 
session_number = 1:         int     	# number
---
session_start_time:         datetime    # start time
session_end_time=null:      datetime	# end time
-> lab.Location
-> lab.Protocol
-> lab.User
-> task.Task
(target_level) -> task.TaskLevelParameterSet.proj('level')
stimulus_bank:             varchar(255)           # path to the function to generate the stimulus
stimulus_commit:           varchar(64)            # git hash for the version of the function
data_dir:                  varchar(255)           # directory of the data
stimulus_set:              tinyint                # 
ball_squal:                float                  # percentage
session_narrative='':      varchar(512)
%}

classdef Session < dj.Manual
end 