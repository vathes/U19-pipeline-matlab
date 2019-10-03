%{
# ActionItems template for the information of each column
-> reference.Template
data :     varchar(64)     
%}

classdef TemplateRightNow < dj.Part
    properties(SetAccess=protected)
        master = reference.Template
    end
end
