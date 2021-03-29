%{
# Parameters related to stimulation control by software during session
software_parameter_set_id        : INT
---
software_parameter_description='': varchar(256)     # string that describes parameter set
software_parameter_hash          : UUID             # uuid hash that encodes parameter dictionary
software_parameters              : longblob         # structure of all parameters

%}

classdef OptogeneticSoftwareParameter < dj.Lookup

end
