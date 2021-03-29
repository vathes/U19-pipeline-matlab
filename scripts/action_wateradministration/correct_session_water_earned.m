

date_key = 'session_date > "2021-01-01"';

session_struct = fetch(acquisition.Session * ...
                       proj(acquisition.SessionStarted, 'remote_path_behavior_file') & ...
                       date_key, '*', 'ORDER BY session_date');
                                      
for j=1:length(session_struct)
    
    [j length(session_struct)]
    
    key = struct();
    key.subject_fullname = session_struct(j).subject_fullname;
    key.session_date     = session_struct(j).session_date
    
    [~, acqsession_file] = lab.utils.get_path_from_official_dir(session_struct(j).remote_path_behavior_file);
    
    %Load behavioral file
    
    data = load(acqsession_file,'log');
    log = data.log;
    
    %updateSessionFromFile_Towers(acquisition.Session,key,log);
    updateWaterEarnedFromFile(action.WaterAdministration, key, log);
    
    
end