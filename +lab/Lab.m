%{
lab:                    varchar(16)  # name of lab
-----
institution:            varchar(64)
address:                varchar(128)
time_zone:              varchar(32)

%}

classdef Lab < dj.Lookup

    properties
        contents = {'tanklab', 'Princeton', 'Princeton Neuroscience Institute, Princeton University Princeton, NJ 08544', 'America/New_York'}
    end
    
end