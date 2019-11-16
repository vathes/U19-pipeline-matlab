%{ 
-> lab.User 
----- 
(secondary_contact) -> lab.User(user_id) 
%}

classdef UserSecondaryContact < dj.Manual 
end