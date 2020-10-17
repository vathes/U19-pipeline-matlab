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

classdef TowersSession < dj.Imported
    
    properties
        %keySource = acquisition.Session & acquisition.SessionStarted
        keySource = acquisition.Session & struct('task', 'Towers');
    end
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            
            %Get behavioral file to load
            data_dir = getLocalPath(fetch1(acquisition.SessionStarted & key, 'remote_path_behavior_file'));
            data = load(data_dir, 'log');
            log = data.log;
            
            self.insertBehTowersSessionFromData(key, log);
            
            %                 [key.rewarded_side, key.chosen_side, key.num_towers_l, key.num_towers_r] = fetchn(...
            %                     acquisition.TowersBlockTrial & key, 'trial_type', 'choice','cue_presence_left', 'cue_presence_right');
            %                 key.maze_id = fetchn(acquisition.TowersBlock * acquisition.TowersBlockTrial & key , 'block_level');
            %
            %                 key.num_towers_l = cellfun(@sum, key.num_towers_l);
            %                 key.num_towers_r = cellfun(@sum, key.num_towers_r);
            %
            %                 % compute various statistics on activity
            %                 self.insert(key);
            %                 sprintf(['Computed statistics for mouse ', key.subject_id, ' on date ', key.session_date, '.']);
            
        end
        
    end
    
    
    methods
        
        function insertBehTowersSessionFromData(self, key,  log)
            
            %Write stimulus_set
            key.stimulus_set = log.animal.stimulusSet;
            
            %Initialize variables to concatenate
            key.rewarded_side = [];
            key.chosen_side = [];
            key.maze_id = [];
            key.num_towers_r = [];
            key.num_towers_l = [];
            
            %For each block get all variables
            for block_idx = 1:length(log.block)
                trialstruct = log.block(block_idx);
                
                rewarded_side = double([trialstruct.trial.trialType]);
                chosen_side = double([trialstruct.trial.choice]);
                %Repeat maze id for each trial
                maze_id = repmat(trialstruct.mazeID, size(chosen_side));
                
                %Separate cueCombo to get towersR and towersL
                cueCombo = {trialstruct.trial.cueCombo};
                num_towers_r = cellfun(@(x) sum(x(Choice.R,:)), cueCombo);
                num_towers_l = cellfun(@(x) sum(x(Choice.L,:)), cueCombo);
                
                
                %Concatenate variables
                key.rewarded_side = [key.rewarded_side rewarded_side];
                key.chosen_side = [key.chosen_side chosen_side];
                key.maze_id = [key.maze_id maze_id];
                key.num_towers_r = [key.num_towers_r num_towers_r];
                key.num_towers_l = [key.num_towers_l num_towers_l];
                       
            end
            
            % Squal not saved in behavorial file before 2020-11-01
            if isfield(log.version.rig, 'squal')
                key.ball_squal = log.version.rig.squal;
            else
                key.ball_squal = -1;
            end
            
            %Finally insert record
            self.insert(key);
            
            
        end
        
    end
end