
%Script to find behavior files for a given set of users
%and call ingestion of acquisition.Session and acquisition.SessionStarted


%Local main directories used by users_id
users_dirs = { ...
    'efonseca',   'efonseca'; ...
    'emdiamanti', 'lpinto'; ...
    'jjulian',    'josh'; ...
    'jounhong',   'ryancho'; ...
    'lpinto',     'lpinto'};
users_dirsT  = cell2table(users_dirs, ...
    'VariableNames',{'user_id' 'user_folder_name'});
users_dirsT.user_id = categorical(users_dirsT.user_id);

%Just check after certain date
from_date = '2020-09-01';
sess_Date_key = ['session_date >= ''' from_date ''''];

%Get all sessions 
fields_query = {'user_id', 'subject_fullname', 'session_location'};
session_struct = fetch(acquisition.Session * subject.Subject & sess_Date_key, fields_query{:});

%Remove data and session number from table (ony unique subject-location)
session_struct = rmfield(session_struct, 'session_date');
session_struct = rmfield(session_struct, 'session_number');

%Get unique subject-location combinations
session_table = struct2table(session_struct);
unique_sessions = unique(session_table,'rows');
unique_sessions.user_id = categorical(unique_sessions.user_id);

%Just keep in table sessions from users_dirs we stated
unique_sessions = unique_sessions(...
                ismember(unique_sessions.user_id,users_dirsT.user_id),:);

%Join tables to get corresponding user_folder_name
unique_sessions = join(unique_sessions,users_dirsT);

%Convert back to cell categorical column
unique_sessions.user_id = cellstr(nominal(unique_sessions.user_id));

% Call ingest_acq_session for every combination
for i=1:size(unique_sessions,1)
    
    disp(['ingestion for ' ...
            ' subject: ' unique_sessions{i,'subject_fullname'}{:} ...
            ' location: ' unique_sessions{i,'session_location'}{:} ...
            ' local folder: ' unique_sessions{i,'user_folder_name'}{:} ...
            ])
    
    ingest_acq_session(unique_sessions{i,'subject_fullname'}{:},...
                       unique_sessions{i,'user_folder_name'}{:}, ...
                       unique_sessions{i,'session_location'}{:})
end