%{
-> acquisition.Session
-----
stimulus_set:          tinyint   # an integer that describes a particular set of stimuli in a trial
ball_squal:            float     # quality measure of ball data
rewarded_side:         blob      # Left or Right X number trials
chosen_side:           blob      # Left or Right X number trials
maze_id:               blob      # level X number trials
num_towers_r:          blob      # Number of towers shown to the right x number of trials
num_towers_l:          blob      # Number of towers shown to the left x tumber of trials
%}

classdef TowersSession < dj.Computed

    methods(Access=protected)
        function makeTuples(self,key)

            [key.rewarded_side, key.chosen_side, key.num_towers_l, key.num_towers_r] = fetchn(acquisition.TowersBlockTrial & key, 'trial_type', 'choice','cue_presence_left', 'cue_presence_right');
            key.maze_id = fetchn(acquisition.TowersBlock * acquisition.TowersBlockTrial & key , 'block_level');
            
            key.num_towers_l = cellfun(@sum, key.num_towers_l);
            key.num_towers_r = cellfun(@sum, key.num_towers_r);
            
            % compute various statistics on activity
            self.insert(key);
            sprintf(['Computed statistics for mouse ', key.subject_id, ' on date ', key.session_date, '.']);
        end
    end
end