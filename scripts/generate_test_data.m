session_key = struct('subject_fullname', 'lpinto_SP11', 'session_date', '2020-01-24');

session_query = acquisition.Session & session_key;
session_started_query = acquisition.SessionStarted & session_key;

session_started_data = fetch(acquisition.SessionStarted & session_key, '*');
session_data = fetch(session_query, '*');

task_data = fetch(task.Task & session_started_query, '*')
task_level_parameter_set_data = fetch(task.TaskLevelParameterSet & session_query, '*');
location_session_data = fetch1(lab.Location & proj(session_query, 'session_location->location'), 'x');


subject_query = subject.Subject & session_query;
subject_data = fetch(subject_query, '*');
line_data = fetch(subject.Line & subject_query, '*');
location_subject_data = fetch1(lab.Location & subject_query, '*');
protocol_subject_data = fetch1(lab.Protocol & subject_query, '*');
user_subject_data = fetch(lab.User & subject_query, '*');

lab_data = fetch1(lab.Lab & 'lab="tank_lab"', '*');
location_data = fetch1(lab.Location & )
