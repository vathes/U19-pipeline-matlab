%{
-> Subject
notification_date:     datetime        # datetime when notification was automatically generated
---
notification_message:  varchar(255)    # Notification message e.g. low bodyweight warning
valid_until_date:      datetime        # datetime when notification was inactivated
%}

classdef SubjectActionAutomatic < dj.Manual
end