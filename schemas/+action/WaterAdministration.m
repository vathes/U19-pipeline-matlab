%{
-> subject.Subject
administration_date:	    date		    # date time
---
earned=null:    float			# water administered
supplement=null: float
received=null: float
-> action.WaterType                         # unknown now
%}

classdef WaterAdministration < dj.Manual
end