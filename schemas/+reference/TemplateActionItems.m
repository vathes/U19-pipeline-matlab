%{
# ActionItems template for the information of each column
-> reference.Template
value                       : varchar(64)                   # 
---
plot_index                  : int                           # index of where to plot in GUI
%}

classdef TemplateActionItems < dj.Part
    properties(SetAccess=protected)
        master = reference.Template
    end
end
