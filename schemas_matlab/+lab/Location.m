%{
# The physical location at which an session is performed or appliances are located.
# This could be a room, a rig or a bench.
location:                   varchar(32)
-----
location_description='':    varchar(255)
%}

classdef Location < dj.Lookup
    properties
        contents = {
            'Benzos2',  ''
            'Benzos3',  ''
            'vivarium', ''
            'pni-171jppw32', ''
            'pni-174cr4jk2', ''
            'valhalla', ''
            }
    end
end