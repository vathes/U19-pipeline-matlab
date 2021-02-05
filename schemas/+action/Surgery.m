%{
-> subject.Subject
surgery_start_time:		datetime        # surgery start time
---
surgery_end_time=null:  datetime        # surgery end time
-> lab.User
-> lab.Location
-> action.SurgeryType
surgery_outcome_type:   enum('success', 'death')	    # outcome type
surgery_narrative=null: varchar(1024)	                # narrative
angle:                  DECIMAL(5,2)                    # (degrees) tilt angle for insertion device (if applicable)
tilt_axis:              enum('AP', 'ML', 'N/A')         # from which axis angle was measured
%}

classdef Surgery < dj.Manual
end