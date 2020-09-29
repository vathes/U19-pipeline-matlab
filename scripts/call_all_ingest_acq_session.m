

t1 = datetime(2020,09,1,0,0,0);
t2 = datetime(2020,10,1,0,0,0);
t = t1:t2;

datechar = datestr(t, 'YYYY-mm-dd');
datecell = mat2cell(datechar,ones(size(datechar,1),1),size(datechar,2));

user = 'lpinto';
mice = {'gps1', 'gps2', 'gps3', 'gps4', 'gps5', 'gps6', 'gps7'};

rigs = {'TrainVR1', 'TrainVR2', 'TrainVR3', 'TrainVR4', 'VRTrain5', 'VRTrain6', 'VRTrain7'}




% mice = {'gps1'}
% rigs = {'TrainVR1'}

%mice = {'gps3'}
%rigs = {'TrainVR3'}

% mice = {'gps4'}
% rigs = {'VRTrain5'}
% 
% mice = {'gps5'}
% rigs = {'VRTrain6'}
% 
% mice = {'gps6'}
% rigs = {'VRTrain7'}

mice = {'gps7'}
rigs = {'TrainVR4'}




for i=1:length(rigs)
    for j=1:length(mice)

        ingest_acq_session(mice{j},user,rigs{i}, datecell)
    end
end