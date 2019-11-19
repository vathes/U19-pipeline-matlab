%{
# General information of a session
-> subject.Subject
session_date                : date                          # date of experiment
session_number              : int                           # number
---
session_start_time          : datetime                      # start time
session_end_time=null       : datetime                      # end time
-> lab.Location
-> task.TaskLevelParameterSet
stimulus_bank = ''          : varchar(255)                  # path to the function to generate the stimulus
stimulus_commit = ''        : varchar(64)                   # git hash for the version of the function
stimulus_set                : tinyint                       # an integer that describes a particular set of stimuli in a trial
session_performance         : float                         # percentage correct on this session
session_narrative = ''      : varchar(512)                  # 
%}

classdef Session < dj.Manual
end 
