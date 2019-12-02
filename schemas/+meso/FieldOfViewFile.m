%{
% field of view information, from the original recInfo.ROI
-> meso.FieldOfView
file_number         : int
---
fov_filename        : varchar(255)     # file name of the fov file name
%}

classdef FieldOfViewFile < dj.Part
    % ingestion handled by ScanInfo
end