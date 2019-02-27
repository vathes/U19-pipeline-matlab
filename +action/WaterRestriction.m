%{
-> subject.Subject
restriction_start_time:     datetime	# start time
---
restriction_end_time=null:  datetime	# end time
initial_weight:             float
restriction_narrative='':   varchar(1024) # comment
%}


classdef WaterRestriction < dj.Manual
end