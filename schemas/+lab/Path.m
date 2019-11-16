%{
global_path         : varchar(255)               # global path name
system              : enum('windows', 'mac', 'linux')
---
local_path          : varchar(255)               # local computer path
net_location        : varchar(255)               # location on the network
description=null    : varchar(255)
%}

classdef Path < dj.Lookup
    properties
        contents = {
            '/bezos', 'windows', 'Y:', '\\bucket.pni.princeton.edu\Bezos-center', ''
            '/bezos', 'mac', '/Volumes/bezos', 'apps.pni.princeton.edu:/jukebox/Bezos', ''
            '/bezos', 'linux', '/mnt/bezos', 'apps.pni.princeton.edu:/jukebox/Bezos', ''
            '/braininit', 'windows', 'Z:', '\\bucket.pni.princeton.edu\braininit', ''
            '/braininit', 'mac', '/Volumes/braininit', 'apps.pni.princeton.edu:/jukebox/braininit', ''
            '/braininit', 'linux', '/mnt/bezos', 'apps.pni.princeton.edu:/jukebox/braininit', ''
        }
    end
end


