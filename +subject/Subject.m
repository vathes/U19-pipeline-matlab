%{
-> lab.Lab
subject_nickname            : char(8)                       # nickname
---
genomics_id=null            : int                           # number from the facility
sex                         : enum('M','F','U')             # sex
subject_birth_date=null     : date                          # birth date
head_plate_mark=null        : blob                          # little drawing on the head plate for mouse identification
-> subject.Line
-> lab.Protocol                  
subject_description=''      : varchar(255)                  # description

%}

classdef Subject < dj.Manual
end
