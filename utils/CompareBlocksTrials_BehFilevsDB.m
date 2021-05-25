

clearvars
this_path = fileparts(mfilename('fullpath'));
file2save = fullfile(this_path, 'sessions_diff_trial_vs_trials.mat');

fields_session = {'subject_fullname', 'session_date'};
fields_trials = {'position', 'iterations'};

date_key = 'session_date > "2011-01-01"' ;

session_struct = fetch(proj(acquisition.Session,'session_location->sess_loc') * acquisition.SessionStarted & date_key, ...
    'remote_path_behavior_file', 'ORDER BY session_date desc');
num_diff_trials = 0;

num_diff_sessions = 0;
for j=1:length(session_struct)
    
    [j length(session_struct)]
    
    %Load behavioral file
    try
        [~, data_dir] = lab.utils.get_path_from_official_dir(session_struct(j).remote_path_behavior_file);
        data = load(data_dir,'log');
        log = data.log;
        status = 1;
    catch err
        status = 0;
    end
    
    if status
        num_blocks = length(log.block);
        num_trials = zeros(num_blocks,1);
        for k=1:num_blocks
            num_trials(k) = length([log.block(k).trial.choice]);
        end
        
        block_struct = fetch(behavior.TowersBlock & session_struct(j));
        num_blocks_db = length(block_struct);
        trials_struct = fetch(behavior.TowersBlockTrial & session_struct(j));
        
        num_trials_db = histcounts([trials_struct.block])';
        if length(num_trials_db) == 1 && num_trials_db == 0
            num_blocks_by_trial_db = 0;
        else
            num_blocks_by_trial_db = length(num_trials_db);
        end
        
        num_trials(num_trials == 0)       = [];
        num_trials_db(num_trials_db == 0) = [];
        
        %Behavioral file and DB differ ....
        if num_blocks ~= num_blocks_db || ...
                ~all(num_trials == num_trials_db)
            
            num_diff_sessions = num_diff_sessions + 1
            
            aux_key = session_struct(j);
            aux_key.num_blocks = num_blocks;
            aux_key.num_trials = num_trials;
            
            aux_key.num_blocks_db = num_blocks_db;
            aux_key.num_trials_db = num_trials_db;
            
            aux_key.num_blocks_by_trial_db = num_blocks_by_trial_db;
            
            session_diff_struct(num_diff_sessions) = aux_key;
        end
        

        
    end
    
end

save(file2save, 'session_diff_struct', '-v7.3')
        
        
