%{
# Animal template for the information of each column
-> reference.Template
field                       : varchar(64)                   # field name, such as 'Cage ID'
---
description                 : varchar(255)                  # description of this field
grouping                    : varchar(16)                   # 
identifier                  : varchar(64)                   # 'cage'
data                        : blob                          # cell array of the data types
future_plans                : enum('yes','no')              # futurePlans for the original template
mandatory                   : enum('yes','no')              # 
is_filter                   : enum('yes','no')              # isFilter for the original template
plot_index                  : int                           # index of where to plot in GUI
%}

classdef TemplateAnimal < dj.Part
    properties(SetAccess=protected)
        master = reference.Template
    end
end
