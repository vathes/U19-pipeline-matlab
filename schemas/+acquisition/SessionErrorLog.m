%{
# Information generated when a session fails
error_log_id                : int AUTO_INCREMENT            # error identifier
---
-> acquisition.SessionStarted
session_phase               : enum('Runtime', 'Population') # at which phase of the experiment error ocurred
error_message               : varchar(512)                  # message of error in matlab  
error_exception             : BLOB                          # mexception structure with error information
%}

classdef SessionErrorLog < dj.Manual
    
    methods(Access=protected)
      
    end
end

