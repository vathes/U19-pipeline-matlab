function [status,data] = read_behavioral_file(inputArg1,inputArg2)
%READ_BEHAVIORAL_FILE, read information from behavioral file

data_dir = fetch1(acquisition.SessionStarted & key, 'task', 'remote_path_behavior_file');


%Load behavioral file
try
    [~, data_dir] = lab.utils.get_path_from_official_dir(data_dir);
    if data_dir.task == "Towers"
        data = load(data_dir,'log');
        status = 1;
    else
        data = load(data_dir);
    end
catch
    disp(['Could not open behavioral file: ', data_dir])
    status = 0;
end

end

