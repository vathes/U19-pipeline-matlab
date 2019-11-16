%{
-> subject.Subject
action_date: date       # date of action
action_id: tinyint      # action id
-----
action: varchar(255)
%}

classdef ActionItem < dj.Manual
end