function ingest_acq_session(subject_id, user_folder, rig, find_paths)
%INGEST_ACQ_SESSION
% Look for missing behavioral files in bucket and add them to u19_acquisition.session % u19_acquisition.SessionStarted
% Only inserts one session per day
%
% Inputs
%  subject      = subject_fullname of the session
%  user_folder  = user that ran the session
%  rig          = rigname of the session

% Execute function to find or generate paths in spock tree
if nargin < 4
    find_paths = 1;
end

verbose = 0;

%Cher for subject in database
subj_key.subject_fullname = subject_id;
subject_db = fetch(subject.Subject & subj_key, 'subject_fullname', 'user_id');

if isempty(subject_db)
    error('There is no such subject in the database')
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
user_directory = fullfile(rig_directory, user_folder);
bucket_directory = fullfile(rig_db.bucket_default_path, user_folder);

%Mark an error if there is no drectory for user in that rig (nickname or user id)
if ~exist(user_directory, 'dir')
    disp(['looking inside this directory: ' user_directory])
    warning('No directory found for inserted user')
    return
end

%Get all files of corresponding subject
current_directory = fileparts(mfilename('fullpath'));
if find_paths
    disp(['looking inside this directory: ' user_directory])
    
    subj_files = RecFindFiles(user_directory, subject_db.subject_fullname, {}, 7, verbose);
    save(fullfile(current_directory, 'subj_files.mat'), 'subj_files')
else
    load(fullfile(current_directory, 'subj_files.mat'), 'subj_files')
end

if isempty(subj_files)
    disp(['No files found for subject ', subject_db.subject_fullname])
end

%Get all files of corresponding subject guessing new subject_fullname
if isempty(subj_files)
    disp(['looking inside this directory for guess subject: ' user_directory])
    
    idx_underscore = strfind(subject_db.subject_fullname, '_');
    guess_subject = '';
    if ~isempty(idx_underscore)
        guess_subject = strrep(subject_db.subject_fullname, subject_db.subject_fullname(1:idx_underscore(1)), '');
    end
    subj_files = RecFindFiles(user_directory, guess_subject, {}, 7, verbose);
    if isempty(subj_files) && ~isempty(guess_subject)
        disp(['No files found for subject (guess) ', guess_subject])
    end
end

%Get all files of corresponding subject guessing new subject_fullname with lower case 
if isempty(subj_files)
    disp(['looking inside this directory: ' user_directory])
    
    idx_underscore = strfind(subject_db.subject_fullname, '_');
    if ~isempty(idx_underscore)
        guess_subject = lower(strrep(subject_db.subject_fullname, subject_db.subject_fullname(1:idx_underscore(1)), ''));
    end
    subj_files = RecFindFiles(user_directory, guess_subject, {}, 7, verbose);
    if isempty(subj_files)
        disp(['No files found for subject (guess) ', subject_db.subject_fullname])
    end
end


bucket_subj_files = cellfun(@(x) strrep(x, user_directory, bucket_directory), subj_files, ...
    'UniformOutput', false);

% For all directories that end with subject id
matfile_pattern = '.mat';
for i=1:length(subj_files)
    
    % Check if file is for given date
    file = subj_files{i}{1};
    bucket_file = bucket_subj_files{i}{1};
    
    ismatfile = regexp(file, matfile_pattern, 'once');
    
    % If is not a mat file is not a behavior session file
    if isempty(ismatfile)
        continue
    end
    
    % Look for date in file and get the corresponding string
    date_idx = regexp(file, '[0-9]{8}');
    if ~isempty(date_idx)
        date_str = file(date_idx:date_idx+7);
        date_str = [date_str(1:4) '-' date_str(5:6) '-' date_str(7:8)];
    end
    
    
    % The file has other date not in array
    if isempty(date_str)
        disp(['Dates do not match this file ', file])
        continue
        % The file is of one of the dates in the array
    else
        
        %Check if session already in database
        sessionkey.subject_fullname = subject_db.subject_fullname;
        sessionkey.session_date = date_str;
        sessionkey.session_number = 0;
        
        %Load behavioral file
        data = load(file, 'log');
        log = data.log;
        
        
        %Insert acq session started
        session_started_db = fetch(acquisition.SessionStarted & sessionkey);
        if ~isempty(session_started_db)
            %disp(['acq.SessionStarted already in database for ', subject_db.subject_fullname, ...
            %      ' for date: ', date_str])
        else
            disp(['Inserting acq.SessionStarted for ', subject_db.subject_fullname, ...
                ' for date: ', date_str])
            %acquisition.SessionStarted.insertSessionStartedFromFile_Towers(...
            %    sessionkey,log, bucket_file, rig_db.bucket_default_path)           
            insert_acq_session_started(file, bucket_file, rig_db.bucket_default_path, subject_db.subject_fullname);
            
        end
        
        
        % Insert acq session
        session_db = fetch(acquisition.Session & sessionkey);
        if ~isempty(session_db)
            %disp(['acq.Session already in database for ', subject_db.subject_fullname, ...
            %      ' for date: ', date_str])
        else
            disp(['Inserting acq.Session for ', subject_db.subject_fullname, ...
                ' for date: ', date_str])
            
            %acquisition.Session.insertSessionFromFile_Towers(sessionkey,log)
            insert_acq_session(file, subject_db.subject_fullname);
            
        end
        
    end
    
end

end

function insert_acq_session(acqsession_file, subject, log)
%INSERT_ACQ_SESSION insert u19_acquisition.session info when file is provided
%
% Input
% acqsession_file  = entire file path for towers task behavior file

log = struct();
try
	load(acqsession_file,'log')
catch err
	disp('Could not load behavioral file')
end

if isfield(log, 'session')
%primary key values
key_session.subject_fullname = subject;
key_session.session_date = sprintf('%d-%02d-%02d', log.session.start(1), log.session.start(2), log.session.start(3));
key_session.session_number = 0;

key_session.session_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.start(1), log.session.start(2), log.session.start(3), log.session.start(4), log.session.start(5));
key_session.session_end_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.end(1), log.session.end(2), log.session.end(3), log.session.end(4), log.session.end(5));

key_session.stimulus_bank = log.block.stimulusBank;
key_session.task = 'Towers';

if length(log.version) > 1
	log.version = log.version(1)
end


key_session.session_location = log.version.rig.rig;
key_session.set_id = 1;


%Get session_performance
correct_number = 0;
counter = 0;
for block_idx = 1:length(log.block)
    trialstruct = log.block(block_idx);
    
    %Get stimulus_bank and level from last block of session
    key_session.stimulus_bank = trialstruct.stimulusBank;
    key_session.level = trialstruct.mainMazeID;
    
    %Calculate correct trials for block
    for itrial = 1:length(trialstruct.trial)
        trial = trialstruct.trial(itrial);
        if isempty(trial.trialType)
            break;
        end
        correct_number = correct_number + strcmp(trial.trialType.char, trial.choice.char);
        counter = counter + 1;
    end
end
if counter ~= 0
	key_session.session_performance = correct_number*100 / counter;
else
	key_session.session_performance = 0;
end

if isstruct(log.animal) && isfield(log.animal, 'protocol')
    protocol3 = func2str(log.animal.protocol);
else
    protocol3 = '';
end


%Prepare session_protocol
session_protocol = [ func2str(log.version.code) '.m' ' ', ...
    log.version.name '.mat' ' ', ...
    protocol3];

key_session.session_protocol = session_protocol;

%Get commit version of session
commit = strsplit(log.version.repository);
commit = commit{1};
key_session.stimulus_commit   = commit;


%Session code_version
key_session.session_code_version = {log.version.mazeVersion, log.version.codeVersion};

%and insert this session:
insert(acquisition.Session, key_session)
end
end


function insert_acq_session_started(acqsession_file, bucket_file_path, rig_default_path, subject)
%INSERT_ACQ_SESSION STARTED insert u19_acquisition.sessionstarted info when file is provided
%
% Input
% acqsession_file  = entire file path for towers task behavior file

local_default_path = 'C:/Data';

log = struct();
try
	load(acqsession_file,'log')
catch err
	disp('Could not open behavioral file')
end

if isfield(log, 'session')

%primary key values
key_session.subject_fullname = subject;
key_session.session_date = sprintf('%d-%02d-%02d', log.session.start(1), log.session.start(2), log.session.start(3));
key_session.session_number = 0;
key_session.remote_path_behavior_file = bucket_file_path;


key_session.session_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.start(1), log.session.start(2), log.session.start(3), log.session.start(4), log.session.start(5));

if length(log.version) > 1
	log.version = log.version(1)
end

key_session.session_location = log.version.rig.rig;


% Get local path from bucket path and rig default path
local_path = strrep(bucket_file_path, rig_default_path, local_default_path);
local_path = fullfile(local_path);
local_path = strrep(local_path, '/', '\');

key_session.local_path_behavior_file  = local_path;


insert(acquisition.SessionStarted, key_session);

end


end





