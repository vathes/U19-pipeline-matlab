%{
user_id:                varchar(32)     # username
----- 
full_name=null:         varchar(32)     # first name
email=null:		        varchar(64)     # email address
phone=null:             varchar(12)     # phone number
carrier=null:           varchar(16)     # phone carrier
slack=null:             varchar(32)     # slack username   
contact_via:            enum('Slack', 'text', 'Email')
presence:		        enum('Available', 'Away')	        
primary_tech='N/A':     enum('yes', 'no', 'N/A')
tech_responsibility='N/A':    enum('yes', 'no', 'N/A')
day_cutoff_time:        blob
slack_webhook:          varchar(255) 
watering_logs=null:     varchar(255)
%}

classdef User < dj.Manual
end

