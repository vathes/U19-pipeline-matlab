%{
cage:  char(8)    # name of a cage
---
(cage_owner) -> lab.User
%}

classdef Cage < dj.Lookup
end