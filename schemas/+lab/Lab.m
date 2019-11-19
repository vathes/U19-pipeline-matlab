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
    end
    
end
