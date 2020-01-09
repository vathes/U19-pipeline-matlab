%{
-> subject.Subject
weighing_time:      datetime
-----
(weigh_person) -> lab.User
-> lab.Location
weight:             float               # in grams
%}

classdef Weighing < dj.Manual
end