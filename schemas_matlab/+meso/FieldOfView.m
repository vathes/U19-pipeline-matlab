%{
% field of view information, from the original recInfo.ROI
-> meso.Scan
fov                 :  tinyint        # number of the field of view in this scan 
---
fov_directory       :  varchar(255)   # the absolute directory created for this fov
fov_name=null       :  varchar(32)    # name of the field of view ("name")
fov_depth           :  float          # depth of the field of view ("Zs") should be a number or a vector? 
fov_center_xy       :  blob           # center position of the field of view ("centerXY")
fov_size_xy         :  blob           # size of the field of view ("sizeXY")
rotation_degrees    :  float          # ("rotationDegrees")
pixel_resolution_xy :  float          # ("pixelResolutionXY")
discrete_plane_mode :  boolean        # ("discretePlaneMode") should this be boolean?
%}

classdef FieldOfView < dj.Imported
    % ingestion handled by ScanInfo
end