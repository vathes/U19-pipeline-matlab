%{
-> lab.Lab
subject_id                  : char(8)                           # nickname
-----
genomics_id=null            : int                               # number from the facility
sex='Unknown'               : enum('Male','Female','Unknown')   # sex
dob=null                    : date                              # birth date
head_plate_mark=null        : blob                              # little drawing on the head plate for mouse identification
-> lab.Location
-> lab.Protocol
-> subject.Line
-> lab.User
act_items=null              : varchar(32)
subject_description=''      : varchar(255)                      # description
%}

classdef Subject < dj.Manual
end