%{
session_type: varchar(32)
%}


classdef SessionType < dj.Lookup
    properties
        contents = {'Training'; 'Imaging'; 'Optogenetics'; 'Ephys'}
    end
end