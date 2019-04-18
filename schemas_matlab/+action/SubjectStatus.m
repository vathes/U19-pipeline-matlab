%{
# table to mark the training/working schedule of the mouse 
-> subject.Subject
effective_date: date
-----
subject_status: enum('InExperiments', 'WaterRestrictionOnly', 'AdLibWater', 'Dead')
water_per_day: float   # in mL
schedule: varchar(255)
%}

classdef SubjectStatus < dj.Manual
end