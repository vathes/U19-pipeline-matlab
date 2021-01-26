%{
# Types of manipulation that can be performed in a experiment
manipulation_type              : varchar(64)
-----
manipulation_description       : varchar(2555)
%}

classdef ManipulationType < dj.Lookup
    properties
    end
end