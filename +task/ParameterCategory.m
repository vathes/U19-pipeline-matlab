%{
parameter_category: varchar(16)
%}


classdef ParameterCategory < dj.Lookup
    properties
        contents = {'maze'; 'criterion'; 'global settings'; 'other'}
    end
end