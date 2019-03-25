db = AnimalDatabase;

users = {'sakoay', 'lucas', 'edward', 'ben'};

for iuser = 1:length(users)
    user = users{iuser};
    animals = fetch(subject.Subject & sprintf('user_id = "%s"', user));
    for animal = animals'
        logs = db.pullDailyLogs(user, animal.subject_id);
       
        key_weigh = animal;
        key_status = animal;
        key_health = animal;
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
            % ingest health status
            key_health.status_date = sprintf('%d-%02d-%02d', ...
                    log.date(1), log.date(2), log.date(3));
  
            if ~isempty(log.normal)
                key_health.normal_behavior = log.normal.strcmp('Yes');
            end
            if ~isempty(log.bcs)
                key_health.bcs = log.bcs;
            end
            if ~isempty(log.activity)
                key_health.activity = log.activity;
            end
           
            if ~isempty(log.eatDrink)
                key_health.eat_drink = log.eatDrink;
            end
            if ~isempty(log.turgor)
                key_health.turgor = log.turgor;
            end
            if ~isempty(log.comments)
                key_health.comments = log.comments;
            end
            inserti(subject.HealthStatus, key_health)
            
            if ~isempty(log.actions)
                for iaction = 1:size(log.actions,1)
                    key_health_action = animal;
                    key_health_action.status_date = key_health.status_date;
                    key_health_action.action_id = iaction;
                    key_health_action.action = log.actions{iaction, 2};
                    inserti(subject.HealthStatusAction, key_health_action)
                end
            end

        end
    end
end


