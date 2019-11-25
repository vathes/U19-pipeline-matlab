%{
# Experimental mouse
mouse_id: int
-----
dob: date                       # date of birth
sex: enum('M', 'F', 'unknown')  # sex of the anmial
%}

classdef Mouse < dj.Manual
end