%{
duty_roaster_date:  date       # date from which this assignment is valid.
----- 
(monday_duty)    -> lab.User(user_id)
(tuesday_duty)   -> lab.User(user_id)
(wednesday_duty) -> lab.User(user_id)
(thursday_duty)  -> lab.User(user_id)
(friday_duty)    -> lab.User(user_id)
(saturday_duty)  -> lab.User(user_id)
(sunday_duty)    -> lab.User(user_id)
%}

classdef DutyRoaster < dj.Manual
end