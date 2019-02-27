%{
-> subject.Subject
weighing_time:      datetime
-----
-> lab.User
weight:             float      # in grams
%}

classdef Weighing < dj.Manual
end