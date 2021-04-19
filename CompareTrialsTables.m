


this_path = fileparts(mfilename('fullpath'));
file2save = fullfile(this_path, 'sessions_different_numblocks_withDB.mat');

fields_session = {'subject_fullname', 'session_date'};
fields_trials = {'position', 'iterations'};

date_key = 'session_date <= "2021-03-30"';

session_struct = fetch(proj(acquisition.Session,'session_location->sess_loc') * acquisition.SessionStarted & date_key, ...
    'remote_path_behavior_file', 'ORDER BY session_date desc');
num_diff_trials = 0;

num_diff_sessions = 0;
for j=1:length(session_struct)
    
        tic
        trial_struct = fetch(behavior.TowersBlockTrial & session_struct(j),'*');
        toc
        disp(['Time original trial table ', num2str(length(trial_struct))])
        tic
        trials_struct = fetch(behavior.TowersBlockTrials & session_struct(j),'*');
        toc
        disp(['Time new trial table', num2str(length(trials_struct))])
   
        tf = isequaln(trial_struct,trials_struct)
    
end
