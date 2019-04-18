%{
project:                    varchar(64)
-----
project_description='':     varchar(255)
%}

classdef Project < dj.Lookup
    properties
        contents = {
            'behavioral task', ''
            'accumulation of evidence', ''
            }
    end
end