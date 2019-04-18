%{
surgery_type:   varchar(32)
%}


classdef SurgeryType < dj.Lookup
    properties
        contents = {'Craniotomy'; 'Hippocampal window'; 'GRIN lens implant'}
    end
end