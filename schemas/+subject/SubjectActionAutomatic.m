%{
-> Subject
notification_date:     datetime        # datetime when notification was automatically generated
---
notification_message:  varchar(255)    # Notification message e.g. low bodyweight warning
%}

classdef SubjectActionAutomatic < dj.Manual
end