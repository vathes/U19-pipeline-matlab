
addpath(genpath('../../pipeline'))

if strcmp(computer, 'MACI64')
    setenv('DB_PREFIX', 'u19_')
else
    setenv('DB_PREFIX', 'shan_')
end


host = env('DJ_HOST');
user = env('DJ_USER');
pw = env('DJ_PASSWORD');
dj.conn(host, user, pw)
