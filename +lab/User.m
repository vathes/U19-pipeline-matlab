%{
-> lab.Lab
user:                   varchar(32)     # username
----- 
email=null:		        varchar(64)     # email address
first_name=null:        varchar(32)     # first name
last_name=null:		    varchar(32)     # last name
date_joined=null:	    datetime	    # date joined
is_active:		        boolean		    # active
is_tech:                boolean
%}

classdef User < dj.Manual
end