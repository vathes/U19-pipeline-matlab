%{
-> subject.Subject
administration_date:	    date		    # date time
---
water_administered=null:    float			# water administered
-> action.WaterType
-> lab.User
%}

classdef WaterAdministration < dj.Manual
end