%{
-> acquisition.Session
block                       : tinyint                       # block number
---
(block_level) -> task.TaskLevelParameterSet(level)
n_trials                    : int                           # number of trials in this block
first_trial                 : int                           # trial_idx of the first trial in this block
block_duration              : float                         # in secs, duration of the block
block_start_time            : datetime                      # absolute start time of the block
reward_mil                  : float                         # in mL, reward volume in this block
reward_scale                : tinyint                       # scale of the reward in this block
easy_block                  : bool                          # true if the difficulty reduces during the session
block_performance           : float                         # performance in the current block
%}

classdef TowersBlock < dj.Imported
    properties
        popRel = acquisition.DataDirectory
    end
    methods(Access=protected)
        function makeTuples(self, key)
            
            data_dir = fetch1(acquisition.DataDirectory & key, 'combined_file_name');
            data = load(data_dir, 'log');
            log = data.log;
            for iBlock = 1:length(log.block)
                tuple = key;
                block = log.block(iBlock);
                tuple.block = iBlock;
                tuple_trial = tuple;
                tuple.task = 'Towers';
                tuple.n_trials = length(block);
                tuple.first_trial = block.firstTrial;
                tuple.block_duration = block.duration;
                tuple.block_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', ...
                    block.start(1), block.start(2), block.start(3), ...
                    block.start(4), block.start(5));
                tuple.reward_mil = block.rewardMiL;
                try
                    tuple.reward_scale = block.trial(1).rewardScale;
                catch
                    tuple.reward_scale = 0;
                end
                tuple.block_level = block.mazeID;
                tuple.easy_block = exists_helper(block,'easyBlockFlag'); %if it doesn't exist, difficulty was uniform
                correct_counter = 0;
                for itrial = 1:length(block.trial)
                    trial = block.trial(itrial);
                    tuple_trial.trial_type = trial.trialType.char; 
                    tuple_trial.choice = trial.choice.char;
                    correct_counter = correct_counter + strcmp(trial.trialType.char, trial.choice.char);
                end
                perf = correct_counter/length(block.trial);
                if isfinite(perf)
                    tuple.block_performance = perf;
                else
                    tuple.block_performance = 0;
                end
                self.insert(tuple);
                
                for itrial = 1:length(block.trial)
                    trial = block.trial(itrial);
                    tuple_trial.trial_idx = itrial;
                    tuple_trial.trial_type = trial.trialType.char; 
                    tuple_trial.choice = trial.choice.char;
                    tuple_trial.trial_time = trial.time;
                    tuple_trial.trial_abs_start = trial.start;
                    tuple_trial.collision = trial.collision;
                    tuple_trial.cue_presence_left = trial.cueCombo(1, :);
                    tuple_trial.cue_presence_right = trial.cueCombo(2, :);
                    
                    if ~isempty(trial.cueOnset{1})
                        tuple_trial.cue_onset_left = trial.cueOnset{1};
                    end
                    
                    if ~isempty(trial.cueOnset{2})
                        tuple_trial.cue_onset_right = trial.cueOnset{2};
                    end
                    
                    if ~isempty(trial.cueOffset{1})
                        tuple_trial.cue_offset_left = trial.cueOffset{1};
                    end
                    
                    if ~isempty(trial.cueOffset{2})
                        tuple_trial.cue_offset_right = trial.cueOffset{2};
                    end
                    
                    if ~isempty(trial.cuePos{1})
                        tuple_trial.cue_pos_left = trial.cuePos{1};
                    end
                    
                    if ~isempty(trial.cuePos{2})
                        tuple_trial.cue_pos_right = trial.cuePos{2};
                    end

                    tuple_trial.trial_duration = trial.duration;
                    tuple_trial.excess_travel = trial.excessTravel;
                    tuple_trial.i_arm_entry = exists_helper(trial,'iArmEntry');
                    tuple_trial.i_blank = exists_helper(trial,'iBlank');
                    tuple_trial.i_turn_entry = exists_helper(trial,'iTurnEntry');
                    tuple_trial.i_cue_entry = exists_helper(trial,'trial.iCueEntry');
                    tuple_trial.i_mem_entry = exists_helper(trial,'trial.iMemEntry');
                    tuple_trial.iterations = trial.iterations;
                    tuple_trial.position = trial.position;
                    tuple_trial.velocity = trial.velocity;
                    tuple_trial.sensor_dots = trial.sensorDots;
                    tuple_trial.trial_id = trial.trialID;
                    if length(trial.trialProb) == 1
                        tuple_trial.trial_prior_p_left = trial.trialProb;
                    else
                        % For not 50:50 trials, take only one of the
                        % probabilities (they add up to 1)
                        tuple_trial.trial_prior_p_left = trial.trialProb(1);
                    end
                    tuple_trial.vi_start = trial.viStart;
                    insert(acquisition.TowersBlockTrial, tuple_trial)
                end
            end
        end
    end
end
    
function [s] = exists_helper(trial, fieldname)
    if isfield(trial, fieldname)
       s = trial.(fieldname);
    else
       s = 0;
    end 
end
