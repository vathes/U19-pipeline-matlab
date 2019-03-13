db = AnimalDatabase;

users = {'sakoay', 'lucas', 'edward', 'ben'};

for iuser = 1:length(users)
    user = users{iuser};
    subjects = fetch(subject.Subject & sprintf('user_id = "%s"', user));
    for subject = subjects'
        logs = db.pullDailyLogs(user, subject.subject_id);
       
        key_weigh = subject;
        key_status = subject;
        for log = logs
             % ingest weighing
            if ~isempty(log.weight)
                key_weigh.weight = log.weight;
                key_weigh.weighing_time = sprintf('%d-%02d-%02d %02d:%02d:00', ...
                    log.date(1), log.date(2), log.date(3), log.weighTime(1), log.weighTime(2));
                key_weigh.weigh_person = log.weighPerson;
                
                if ~isempty(log.weighLocation)
                    key_loc.location = log.weighLocation;
                    inserti(lab.Location, key_loc)
                end
                key_weigh.location = log.weighLocation;
                inserti(action.Weighing, key_weigh)
                
            end

        end
    end
end


