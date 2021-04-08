%{
-> acquisition.SessionBlock
trial_idx:          int     # trial index, keep the original number in the file
---
trial_type:                 enum('L', 'R')          # answer of this trial, left or right
choice:                     enum('L', 'R', 'nil')   # choice of this trial, left or right
trial_abs_start:            float                   # start time of the trial realtive to the beginning of the session
trial_duration:             float                   # duration of the entire trial
events=null:                blob@extstorage         # specific time events during trial
%}


%List of events from towers task into events structure:

% cue_presence_left:          blob     # boolean vector for the presence of the towers on the left
% cue_presence_right:         blob     # boolean vector for the presence of the towers on the right
% cue_onset_left=null:        blob     # onset time of the cues on the left (only for the present ones)
% cue_onset_right=null:       blob     # onset time of the cues on the right (only for the present ones)
% cue_offset_left=null:       blob     # offset time of the cues on the left (only for the present ones)
% cue_offset_right=null:      blob     # offset time of the cues on the right (only for the present ones)
% cue_pos_left=null:          blob     # position of the cues on the left (only for the present ones)
% cue_pos_right=null:         blob     # position of the cues on the right (only for the present ones)
% excess_travel:              float    #
% i_arm_entry:                int      # the index of the time series when the mouse enters the arm part
% i_blank:                    int      # the index of the time series when the mouse enters the blank zone
% i_cue_entry:                int      # the index of the time series when the mouse neters the cue zone
% i_mem_entry:                int      # the index of the time series when the mouse enters the memory zone
% i_turn_entry:               int      # the index of the time series when the mouse enters turns
% iterations:                 int      # length of the meaningful recording
% trial_id:                   int      #
% trial_prior_p_left:         float    # prior probablity of this trial for left
% vi_start:                   int      #

classdef SessionBlockTrial < dj.Part
    properties(SetAccess=protected)
        master = acquisition.SessionBlock
    end
    
%     methods(Access=protected)
%         function makeTuples(self, key)
%            s = 0 
%         end
%     
%     end
    
    methods
        
        function ingestFromBehaviorBlockTrial(self)
            %Function to copy over trials from behavior.TowersBlockTrial -> acquisition.SessionBlockTrial
            warning('off','MATLAB:MKDIR:DirectoryExists')
            % Which fields we need from behavior.TowersBlockTrial
            needed_fields = {'trial_type', 'choice', 'trial_abs_start', 'trial_duration', 'trial_time', ...
                'cue_presence_left', 'cue_presence_right', 'cue_onset_left', 'cue_onset_right', ...
                'cue_offset_left',   'cue_offset_right',    'cue_pos_left',   'cue_pos_right', ...
                'excess_travel', 'i_arm_entry', 'i_blank', 'i_cue_entry', 'i_mem_entry', 'i_turn_entry', ...
                'iterations', 'trial_id', 'trial_prior_p_left', 'vi_start'};
            
            % Fields that are copied exactly as they are from behavior.TowersBlockTrial
            direct_fields = {'subject_fullname', 'session_date', 'session_number', 'block', 'trial_idx', ...
                'trial_type', 'choice', 'trial_abs_start', 'trial_duration'};
            
            
            all_sessions = fetch(acquisition.Session - self);
            
            %For all sessions
            for i=1:length(all_sessions)
                
                [i length(all_sessions)]
                
                %Get trial information
                trial_info = fetch(behavior.TowersBlockTrial & all_sessions(i), needed_fields{:});
                
                if ~isempty(trial_info)
                    
                    %Make a table from trial information
                    table_trial = struct2table(trial_info, 'AsArray',true);
                    subset_table_trial = table_trial(:, direct_fields);
                    
                    % For all other fields that are not direct, create a structure to copy them over on the "events"
                    % field
                    for j=1:length(trial_info)
                        
                        curr_events.cue_presence_left  =   trial_info(j).cue_presence_left;
                        curr_events.cue_presence_right =   trial_info(j).cue_presence_right;
                        
                        %For some events we save time rather than iteration
                        curr_events.t_cue_onset_left     =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_onset_left);
                        curr_events.t_cue_onset_right    =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_onset_right);
                        
                        curr_events.t_cue_offset_left    =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_offset_left);
                        curr_events.t_cue_offset_right    =  get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_offset_right);
                        
                        curr_events.cue_pos_left       =   trial_info(j).cue_pos_left;
                        curr_events.cue_pos_right      =   trial_info(j).cue_pos_right;
                        
                        curr_events.excess_travel      =   trial_info(j).excess_travel;
                        
                        curr_events.t_arm_entry        =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_arm_entry);
                        
                        curr_events.t_blank            =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_blank);
                        
                        curr_events.t_cue_entry        =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_cue_entry);
                        
                        curr_events.t_mem_entry        =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_mem_entry);
                        
                        curr_events.t_turn_entry       =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_turn_entry);
                        
                        curr_events.iterations         = trial_info(j).iterations;
                        curr_events.trial_id           = trial_info(j).trial_id;
                        curr_events.trial_prior_p_left = trial_info(j).trial_prior_p_left;
                        curr_events.vi_start           = trial_info(j).vi_start;
                        
                        %Store all events in a single structure array
                        all_events(j,1) = curr_events;
                        
                    end
                    
                    subset_table_trial.events = all_events;
                    clear all_events
                    
                    %Pass to structrue and insert trials from entire session
                    subset_struct_trial = table2struct(subset_table_trial);   
                    
                    disp('Before insert')
                    tic
                    for j=1:length(subset_struct_trial)
                        insert(self, subset_struct_trial(j), 'IGNORE');
                    end
                    toc
                    
                end
            end
            
            warning('on','MATLAB:MKDIR:DirectoryExists')
        end
        
       function updateEventsFromBehaviorBlockTrial(self)
            %Function to copy over trials from behavior.TowersBlockTrial -> acquisition.SessionBlockTrial
            
            % Which fields we need from behavior.TowersBlockTrial
            needed_fields = {'trial_type', 'choice', 'trial_abs_start', 'trial_duration', 'trial_time', ...
                'cue_presence_left', 'cue_presence_right', 'cue_onset_left', 'cue_onset_right', ...
                'cue_offset_left',   'cue_offset_right',    'cue_pos_left',   'cue_pos_right', ...
                'excess_travel', 'i_arm_entry', 'i_blank', 'i_cue_entry', 'i_mem_entry', 'i_turn_entry', ...
                'iterations', 'trial_id', 'trial_prior_p_left', 'vi_start'};
            
            % Fields that are copied exactly as they are from behavior.TowersBlockTrial
            key_fields = {'subject_fullname', 'session_date', 'session_number', 'block', 'trial_idx'};
            
            temp_subj_key = 'subject_fullname = "efonseca_EF002"'
            temp_date_key = 'session_date >= "2020-02-25" and session_date <= "2020-03-04"'
            all_sessions = fetch(acquisition.Session & temp_subj_key & temp_date_key);
            
            %For all sessions
            for i=1:length(all_sessions)
                
                [i length(all_sessions)]
                
                %Get trial information
                trial_info = fetch(behavior.TowersBlockTrial & all_sessions(i), needed_fields{:});
                
                if ~isempty(trial_info)
                    
                    %Make a table from trial information
                    table_trial = struct2table(trial_info, 'AsArray',true);
                    subset_table_trial = table_trial(:, key_fields);
                    subset_struct_trial = table2struct(subset_table_trial);  
                    
                    % For all other fields that are not direct, create a structure to copy them over on the "events"
                    % field
                    for j=1:length(trial_info)
                        
                        curr_events.cue_presence_left  =   trial_info(j).cue_presence_left;
                        curr_events.cue_presence_right =   trial_info(j).cue_presence_right;
                        
                        %For some events we save time rather than iteration
                        curr_events.t_cue_onset_left     =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_onset_left);
                        curr_events.t_cue_onset_right    =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_onset_right);
                        
                        curr_events.t_cue_offset_left    =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_offset_left);
                        curr_events.t_cue_offset_right    =  get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).cue_offset_right);
                        
                        curr_events.cue_pos_left       =   trial_info(j).cue_pos_left;
                        curr_events.cue_pos_right      =   trial_info(j).cue_pos_right;
                        
                        curr_events.excess_travel      =   trial_info(j).excess_travel;
                        
                        curr_events.t_arm_entry        =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_arm_entry);
                        
                        curr_events.t_blank            =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_blank);
                        
                        curr_events.t_cue_entry        =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_cue_entry);
                        
                        curr_events.t_mem_entry        =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_mem_entry);
                        
                        curr_events.t_turn_entry       =   get_time_from_iter(trial_info(j).trial_time, ...
                            trial_info(j).i_turn_entry);
                        
                        curr_events.iterations         = trial_info(j).iterations;
                        curr_events.trial_id           = trial_info(j).trial_id;
                        curr_events.trial_prior_p_left = trial_info(j).trial_prior_p_left;
                        curr_events.vi_start           = trial_info(j).vi_start;
                        
                        update(self & subset_struct_trial(j), 'events', curr_events);
                        
                    end
                
                end
            end
            
        end
                
        
    end
    
end