
%{
# available motion correction method
mcorr_method:           varchar(128)
---
correlation_type: enum('Normalized', 'Non-Normalized')
tranformation_type: enum('Linear', 'Non-linear')
%}

    
 classdef MotionCorrectionMethod < dj.Lookup
     properties
        contents = {'LinerNormalized', 'Normalized', 'Linear';
                    'NonLinerNormalized', 'Normalized', 'Nonlinear'};
     end
 end