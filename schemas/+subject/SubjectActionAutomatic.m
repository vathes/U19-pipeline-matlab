%{
-> subject.Subject
notification_date = '1900-01-01 00:00:00':     datetime        # datetime when notification was automatically generated
---
notification_message:       varchar(255)    # Notification message e.g. low bodyweight warning
valid_until_date=null:      datetime        # datetime when notification was inactivated
%}

classdef SubjectActionAutomatic < dj.Manual
end