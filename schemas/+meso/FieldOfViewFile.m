%{
% field of view information, from the original recInfo.ROI
-> meso.FieldOfView
file_number         : int
---
fov_filename        : varchar(255)     # file name of the new fov tiff file

%}

classdef FieldOfViewFile < dj.Part
    properties(SetAccess=protected)
        master = meso.FieldOfView
    end
    % ingestion handled by meso.FieldOfView
end