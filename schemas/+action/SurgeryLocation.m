%{
-> action.Surgery
device_idx:                   int
---
-> lab.InsertionDevice
hemisphere:                   enum('L', 'R', 'Bilateral')
-> reference.BrainLocation
real_ap_coordinates:          decimal(5,2)     # anteroposterior coordinates in mm   
real_dv_coordinates:          decimal(5,2)     # dorsoventral coordinates in mm
real_ml_coordinates:          decimal(5,2)     # mediolateral coordinates in mm
%}


classdef SurgeryLocation < dj.Manual
end