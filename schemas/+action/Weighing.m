%{
-> subject.Subject
weighing_time:      datetime
-----
(weigh_person) -> lab.User
-> lab.Location
weight:             float               # in grams
low_weight_alert='':   varchar(255)     # low weight alert message, when weight < 0.8*initial_weight
%}

classdef Weighing < dj.Manual
end