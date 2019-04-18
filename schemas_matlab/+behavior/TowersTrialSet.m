%{
-> acquisition.Session
---
number_of_trials: int   # number of trials in this session
%}


classdef TowersTrialSet < dj.Imported
    methods
        function makeTuples(self, key)
            filename = [key.subject '/' key.session_date];
            data = load(filename);
            
            key.number_of_trials = length(data);
            self.insert(key)
            
            for itrial = 1:length(trials)
                %
                insert(behavior.TowersTrial, key_trial)
            end
            
        end
    end
end