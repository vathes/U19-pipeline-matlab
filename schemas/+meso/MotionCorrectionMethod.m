
%{
# available motion correction method
mcorr_method:           varchar(128)
---
correlation_type='Normalized' : enum('Normalized', 'Non-Normalized')
tranformation_type='Linear'   : enum('Linear', 'Non-linear')
%}

    
 classdef MotionCorrectionMethod < dj.Lookup
     properties
        contents = {'LinerNormalized', 'Normalized', 'Linear';
                    'NonLinerNormalized', 'Normalized', 'Nonlinear'};
     end
 end