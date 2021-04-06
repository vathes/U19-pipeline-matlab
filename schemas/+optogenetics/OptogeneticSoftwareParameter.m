%{
# Parameters related to stimulation control by software during session
software_parameter_set_id        : INT
---
software_parameter_description='': varchar(256)     # string that describes parameter set
software_parameter_hash          : UUID             # uuid hash that encodes parameter dictionary
software_parameters              : longblob         # structure of all parameters
%}

classdef OptogeneticSoftwareParameter < dj.Lookup
    properties (Constant = true)
    s1 = struct('param1', 1, 'param2', 2);
    s2 = struct('param1', 1, 'paramx', 2);
    contents = ...
    {1, 'Parameters for airpuff task', ...,
        struct2uuid(optogenetics.OptogeneticSoftwareParameter.s1), ...
        optogenetics.OptogeneticSoftwareParameter.s1;
     2, 'Parameters for context task', ...,
        struct2uuid(optogenetics.OptogeneticSoftwareParameter.s2), ...
        optogenetics.OptogeneticSoftwareParameter.s2
    }
    end
end
