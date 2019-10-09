%{
# ActionItems template for the information of each column
-> reference.Template
data                        : varchar(64)                   # 
---
plot_index                  : int                           # index of where to plot in GUI
%}

classdef TemplateRightNow < dj.Part
    properties(SetAccess=protected)
        master = reference.Template
    end
end
