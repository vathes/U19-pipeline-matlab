%{
-> subject.Subject
weighing_time:      datetime
-----
(weigh_person) -> lab.User
-> lab.Location
weight:             float      # in grams
weight_notice='':   varchar(255)
%}

classdef Weighing < dj.Manual
end