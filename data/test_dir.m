keys = fetch(acquisition.Session & 'subject_id = "E38"' & 'session_date = "2017-10-18"');
key = keys(1);
base_dir = '/Volumes/braininit/RigData/training/';
[user, rig, subject, session_date] = fetch1(...
    acquisition.Session & key, 'user_id', 'location', 'subject_id', 'session_date');
session_date = erase(session_date, '-');
rig_number = rig(regexp(rig, '[0-9]'));
file = dir([base_dir 'rig' rig_number '/' user '/*/data/' subject '/*_' session_date '.mat']);
