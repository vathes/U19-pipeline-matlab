%{
-> task.Task
subtask               : varchar(32)
---
subtask_description='': varchar(512)
%}

classdef Subtask < dj.Lookup
    properties

    end
end
