%{
-> acquisition.Session
block:              tinyint     # block number
---
(block_level) -> task.TaskLevelParameterSet(task_level)
n_trials:           int         # number of trials in this block
first_trial:        int         # trial_idx of the first trial in this block
block_duration:     float       # in secs, duration of the block
block_start_time:   datetime    # absolute start time of the block
reward_mil:         float       # in mL, reward volume in this block
reward_scale:       tinyint     # scale of the reward in this block
easy_block:         bool        # true if the difficulty reduces during the session
%}

classdef TowersBlock < dj.Imported
    properties
        popRel = acquisition.Session
    end
    
    methods
        function makeTuples(self, key)
            
            data_dir = fetch1(acquisition.Session & key, 'data_dir');
            log = load(data_dir, 'log');
            tuple = key;
            for iBlock = 1:length(log.block)
                block = log.block(iBlock);
                tuple.block = iBlock;
                tuple_trial = tuple;
                tuple.n_trials = length(block);
                tuple.first_trial = block.firstTrial;
                tuple.block_duration = block.duration;
                tuple.block_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', ...
                    block.start(1), block.start(2), block.start(3), ...
                    block.start(4), block.start(5));
                tuple.reward_mil = block.rewardMiL;
                tuple.reward_scale = block.trial(1).reward_scale;
                tuple.block_level = block.mazeID;
                tuple.easy_block = block.easyBlockFlag;
                self.insert(tuple);
                
                for itrial = 1:length(block.trial)
                    tiral = block.trial(itrial);
                    tuple_trial.trial_type = trial.trialID; 
                    tuple_trial.choice =                     enum('L', 'R', 'Time Out')   # choice of this trial, left or right
                    tuple_trial.trial_time:                 longblob # time series of this trial, start from zero for each trial
                    tuple_trial.trial_abs_start:            float    # absolute start time of the trial realtive to the beginning of the session
                    tuple_trial.collision:                  longblob # boolean vector indicating whether the subject hit the maze on each time point
                    tuple_trial.cue_presence_left:          blob     # boolean vector for the presence of the towers on the left
                    tuple_trial.cue_presence_right:         blob     # boolean vector for the presence of the towers on the right
                    tuple_trial.cue_onset_left=null:        blob     # onset time of the cues on the left (only for the present ones)
                    tuple_trial.cue_onset_right=null:       blob     # onset time of the cues on the right (only for the present ones)
                    tuple_trial.cue_offset_left=null:       blob     # offset time of the cues on the left (only for the present ones)
                    tuple_trial.cue_offset_right=null:      blob     # offset time of the cues on the right (only for the present ones)
                    tuple_trial.cue_pos_left=null:          blob     # position of the cues on the left (only for the present ones)
                    tuple_trial.cue_pos_right=null:         blob     # position of the cues on the right (only for the present ones)
                    trial_duration:             float    # duration of the entire trial
                    excess_travel:              float    # 
                    i_arm_entry:                int      # the index of the time series when the mouse enters the arm part
                    i_blank:                    int      # the index of the time series when the mouse enters the blank zone
                    i_cue_entry:                int      # the index of the time series when the mouse neters the cue zone
                    i_mem_entry:                int      # the index of the time series when the mouse enters the memory zone 
                    i_turn_entry:               int      # the index of the time series when the mouse enters turns
                    iterations:                 int      # length of the meaningful recording
                    position:                   longblob # 3d recording of the position of the mouse, length equals to interations
                    velocity:                   longblob # 3d recording of the velocity of the mouse, length equals to interations
                    sensor_dots:                longblob # raw recordings of the ball
                    trial_difficulty:           int      # some measure of the difficulty of this trial
                    trial_prior_p_left:         float    # prior probablity of this trial for left
                    vi_start:                   int      # 
                end
            end
            
        end
    end
end