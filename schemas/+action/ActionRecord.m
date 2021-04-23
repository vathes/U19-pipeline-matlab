%{
-> subject.Subject      # Record of the action items performed every day on each subject
action_date: date       # date of action
action_id: tinyint      # action id
-----
action: varchar(255)
%}

classdef ActionRecord < dj.Manual
end