%{
-> subject.Subject
status_date:  date
-----
normal_behavior=null:     boolean      
bcs=null:                 tinyint          # Body Condition Score, from 1 (emaciated i.e. very malnourished) to 5 (obese), 3 being normal
activity=null:            tinyint          # score from 0 (moves normally) to 3 (does not move) -1 unknown
posture_grooming=null:    tinyint          # score from 0 (normal posture + smooth fur) to 3 (hunched + scruffy) -1 unknown
eat_drink=null:           tinyint          # score from 0 (normal amounts of feces and urine) to 3 (no evidence of feces or urine) -1 unknown
turgor=null:              tinyint          # score from 0 (skin retracts within 0.5s) to 3 (skin retracts in more than 2 s) -1 unknown
comments=null:       varchar(255)
%}

classdef HealthStatus < dj.Manual
end