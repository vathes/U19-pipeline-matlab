%{
# General information of a session
error_log_id                : int AUTO_INCREMENT            # error identifier
---
-> acquisition.SessionStarted
session_phase               : enum('Runtime', 'Population') # at which phase of the experiment error ocurred
error_message               : varchar(512)                  # message of error in matlab  
error_stack                 : BLOB                          # set of functions where error occured
%}

classdef SessionErrorLog < dj.Manual
    
    methods(Access=protected)
      
    end
end

