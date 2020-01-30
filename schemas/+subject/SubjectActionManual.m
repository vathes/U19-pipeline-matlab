%{
-> subject.Subject
-> subject.ActItem
notification_date = '1900-01-01 00:00:00':     datetime        # datetime when notification was generated
---
valid_until_date  = null:      datetime        # datetime when notification was inactivated
%}

classdef SubjectActionManual < dj.Manual
end