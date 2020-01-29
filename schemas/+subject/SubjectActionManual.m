%{
-> Subject
-> ActItem
---
notification_date:     datetime        # datetime when notification was generated
valid_until_date:      datetime        # datetime when notification was inactivated
%}

classdef SubjectActionManual < dj.Manual
end