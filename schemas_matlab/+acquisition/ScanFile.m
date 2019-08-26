%{
-> acquisition.Scan
file_number    : int             # file number of a given scan
---
scan_filename  : varchar(255)    
%}
        
        
classdef ScanFile < dj.Part
end
    
