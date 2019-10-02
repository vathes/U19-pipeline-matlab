%{
# ActionItems template for the information of each column
-> reference.Template
value :     varchar(64)     
%}

classdef TemplateActionItems < dj.Part
    properties(SetAccess=protected)
        master = reference.Template
    end
end
