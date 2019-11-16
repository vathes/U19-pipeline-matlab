%{
# 
lab                         : varchar(16)                   # name of lab
---
institution                 : varchar(64)                   # 
address                     : varchar(128)                  # 
time_zone                   : varchar(32)                   # 
pi_name                     : varchar(64)                   # 
%}

classdef Lab < dj.Lookup

    properties
        contents = {'tanklab', 'Princeton', 'Princeton Neuroscience Institute, Princeton University Princeton, NJ 08544', 'America/New_York', 'D. W. Tank';
                    'wittenlab', 'Princeton', 'Princeton Neuroscience Institute, Princeton University Princeton, NJ 08544', 'America/New_York', 'I. Witten';
        }
    end
    
end
