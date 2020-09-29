function ingest_acq_session(subject_id, user, rig, dates)
%INGEST_ACQ_SESSION
% Look for missing behavioral files in bucket and add them to u19_acquisition.session
%
% Inputs
%  subject   = subject of the sessions
%  user      = user that ran the session
%  rig       = rigname of the session
%  dates     = date range of the session


%Cher for subject in database
subj_key.subject_fullname = subject_id;
[subject_db] = fetch(subject.Subject & subj_key, 'subject_fullname', 'user_id');

if isempty(subject_db)
    error('There is no such subject in the database')
end

%Check for user in database (id or nickname)
status = true;
%Check user_id
user_key.user_id = user;
user_db = fetch(lab.User & user_key, 'user_id', 'user_nickname');
if isempty(user_db)
    status = false;
end
%if is not there check user nickname
if ~status
    user_key2.user_nickname = user;
    user_db = fetch(lab.User & user_key2, 'user_id', 'user_nickname');
end
%user not found or user is not the same
if isempty(user_db)
    error('User not found in database')
elseif ~strcmp(user_db.user_id, subject_db.user_id)
    warning('User provided and subject''s user are not same user')
end

%Check rig existence
rigkey.location = rig;
rig_db = fetch(lab.Location & rigkey, 'location', 'bucket_default_path');
if isempty(rig_db)
    error('There is no such rig in the database')
end
% Get rig default path for behavior files
rig_directory = lab.utils.format_bucket_path(rig_db.bucket_default_path);
lab.utils.assert_mounted_location(rig_directory);

% Get user directory for specific rig
user_directory = fullfile(rig_directory, user_db.user_nickname);

%Mark an error if there is no drectory for user in that rig (nickname or user id)
if ~exist(user_directory, 'dir')
    status = false;
end
if ~status
    user_directory = fullfile(rig_directory, user_db.user_id);
end
if ~exist(user_directory, 'dir')
    error('No directory found for inserted user')
end

%Get all files of corresponding subject
subj_files = RecFindFiles(user_directory, subject_db.subject_fullname, {}, 7);
save('subj_files.mat', 'subj_files')
load('subj_files.mat', 'subj_files')


if isempty(subj_files)
    warning(['No files found for subject ', subject_db.subject_fullname])
end
            
% For all directories that end with subject id            
date_pattern = '.mat';   
dates_nodash = strrep(dates, '-', '');
for i=1:length(subj_files)         

% Check if file is for given date
file = subj_files{i}{1}
ismatfile = regexp(file, date_pattern, 'once');

% If is not a mat file is not a behavior session file
if isempty(ismatfile)
    continue
end

% Check the date of the file and if it correspond to given date array
idx_dates = cellfun(@(x) regexp(file,x,'once'), dates_nodash,'UniformOutput',false);
idx_dates = find(~cellfun(@isempty, idx_dates));

% The file has other date not in array
if isempty(idx_dates)
    disp(['Dates do not match this file ', file])
    continue
% The file is of one of the dates in the array
else
    date = dates{idx_dates(1)}
    %Check if session already in database
    sessionkey.subject_fullname = subject_db.subject_fullname;
    sessionkey.session_date = date;
    session_db = fetch(acquisition.Session & sessionkey)
    if ~isempty(session_db)
        disp(['Session already in database for ', subject_db.subject_fullname, ...
              'for date: ', date])
    else
        disp('Inserting session in db');
        insert_acq_session(file, subject_db.subject_fullname);
    end
end

end

end

