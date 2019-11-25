
addpath(genpath('../../pipelines'))
setenv('DB_PREFIX', 'u19_')

host = env('DJ_HOST');
user = env('DJ_USER');
pw = env('DJ_PASSWORD');
dj.conn(host, user, pw)
