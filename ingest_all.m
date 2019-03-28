
disp 'Creating schemas ...'
create_schemas

disp 'Ingest mice information ...'
ingest_mice

disp 'Ingest tasks ...'
ingest_task_tables

disp 'Ingest mouse logs ...'
ingest_mouse_logs

disp 'Ingest trial information ...'
populate_tables