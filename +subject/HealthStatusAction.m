%{
-> subject.HealthStatus
-> action_id
-----
action: varchar(255)
%}

classdef HealthStatusAction < dj.Part

	properties(SetAccess=protected)
		master= subject.HealthStatus
	end

end