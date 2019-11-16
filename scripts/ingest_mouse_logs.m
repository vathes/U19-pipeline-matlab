db = AnimalDatabase;

users = fetchn(lab.User, 'user_id');


for iuser = 1:length(users)
    user = users{iuser};
    animals = fetch(subject.Subject & sprintf('user_id = "%s"', user));
    for animal = animals'
        logs = db.pullDailyLogs(user, animal.subject_id);
       
        key_weigh = animal;
        key_status = animal;
        key_water_admin = animal;
        key_health = animal;
        key_session = animal;
        for log = logs
             % ingest weighing
            if ~isempty(log.weight)
                key_weigh.weight = log.weight;
                
                if ~isempty(log.weighTime)
                    key_weigh.weighing_time = sprintf('%d-%02d-%02d %02d:%02d:00', ...
                        log.date(1), log.date(2), log.date(3), log.weighTime(1), log.weighTime(2));
                else
                    key_weigh.weighing_time = sprintf('%d-%02d-%02d 12:00:00', ...
                        log.date(1), log.date(2), log.date(3));
                end

                key_weigh.weigh_person = log.weighPerson;
                
                if ~isempty(log.weighLocation)
                    key_loc.location = log.weighLocation;
                    inserti(lab.Location, key_loc)
                end
                key_weigh.location = log.weighLocation;
                inserti(action.Weighing, key_weigh)
                
            end
            % ingest water administration info
            if ~isempty(log.received)
                key_water_admin.administration_date = sprintf('%d-%02d-%02d', ...
                    log.date(1), log.date(2), log.date(3));
                key_water_admin.earned = log.earned;
                key_water_admin.supplement = log.supplement;
                key_water_admin.received = log.received;
                key_water_admin.watertype_name = 'Unknown';
                inserti(action.WaterAdministration, key_water_admin)
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
                    key_action = animal;
                    key_action.action_date = key_health.status_date;
                    key_action.action_id = iaction;
                    key_action.action = log.actions{iaction, 2};
                    inserti(action.ActionItem, key_action)
                end
            end
            % ingest session
            if ~isempty(log.trainStart) && ~isempty(log.mainMazeID) % TODO: ingest trainings without mainMazeID
                key_session.session_date = sprintf('%d-%02d-%02d', ...
                    log.date(1), log.date(2), log.date(3));
                key_session.session_start_time = sprintf('%d-%02d-%02d %2d:%2d:00', ...
                    log.date(1), log.date(2), log.date(3), log.trainStart(1), log.trainStart(2));
                key_session.session_end_time = sprintf('%d-%02d-%02d %2d:%2d:00', ...
                    log.date(1), log.date(2), log.date(3), log.trainEnd(1), log.trainEnd(2));
                
                % ingest locations
                key_location.location = log.rigName;
                inserti(lab.Location, key_location)
                
                key_session.location = log.rigName;
                key_session.user_id = user;
                key_session.task = 'Towers';
                key_session.level = log.mainMazeID;
                key_session.set_id = 1;
                key_session.stimulus_bank = log.stimulusBank;
                key_session.stimulus_set = log.stimulusSet;
                key_session.ball_squal = log.squal;
                key_session.session_performance = log.performance;
                
                inserti(acquisition.Session, key_session)
            end
            
        end
    end
end

