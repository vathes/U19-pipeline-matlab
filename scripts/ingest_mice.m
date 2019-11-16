%% load database
db = AnimalDatabase;


%% insert user information
overview = db.pullOverview;

for i = 1:length(overview.Technicians)
    tech = overview.Technicians(i);
    key_tech = struct(...
        'user_id', tech.ID, ...
        'full_name', tech.Name, ...
        'email', tech.Email, ...
        'phone', tech.Phone, ...
        'carrier', tech.Carrier, ...
        'slack', tech.Slack, ...
        'slack_webhook', tech.slackWebhook, ...
        'contact_via', tech.ContactVia, ...
        'presence', tech.Presence, ...
        'primary_tech', tech.primaryTech, ...
        'day_cutoff_time', tech.DayCutoffTime ...
    );
    inserti(lab.User, key_tech) 
end

for i = 1:length(overview.Researchers)
    researcher = overview.Researchers(i);
    key_researcher = struct( ...
        'user_id', researcher.ID, ...
        'full_name', researcher.Name, ...
        'email', researcher.Email, ...
        'phone', researcher.Phone, ...
        'carrier', researcher.Carrier, ...
        'slack', researcher.Slack, ...
        'contact_via', researcher.ContactVia, ...
        'presence', researcher.Presence, ...
        'tech_responsibility', researcher.TechResponsibility, ...
        'day_cutoff_time', researcher.DayCutoffTime ...
    );
    
    if ~isempty(researcher.slackWebhook)
        key_researcher.slack_webhook = researcher.slackWebhook;
    end

    if ~isempty(researcher.wateringLogs)
        key_researcher.watering_logs = researcher.wateringLogs;
    end
    inserti(lab.User, key_researcher)
    
    key_userlab.user_id = researcher.ID;
    if ~isempty(researcher.PI)
        switch researcher.PI
            case 'D. W. Tank'
                key_userlab.lab = 'tanklab';
            case 'I. Witten'
                key_userlab.lab = 'wittenlab';
        end
        inserti(lab.UserLab, key_userlab)
    end
    
    key_userproc.user_id = researcher.ID;
    if ~isempty(researcher.Protocol)
        key_proc.protocol = researcher.Protocol;
        inserti(lab.Protocol, key_proc)
        key_userproc.protocol = researcher.Protocol;
        inserti(lab.UserProtocol, key_userproc)
    end
        
end


%% insert subject information
animals = db.pullAnimalList;

for igroup = 1:length(animals)
    animal_group = animals{igroup};
   
    if ~isempty(animal_group)
        for ianimal = 1:length(animal_group)
            animal = animal_group(ianimal);
            key_subj = struct( ...
                'user_id', animal.owner, ...
                'subject_id', animal.ID, ...
                'location', animal.whereAmI ...
            );
            
            if ~isempty(animal.sex)
                key_subj.sex = animal.sex.char;
            end
            
            if ~isempty(animal.image)
                key_subject.head_plate_mark = animal.image;
            end
        
            if ~isempty(animal.dob)
                key_subj.dob = sprintf('%d-%02d-%02d', animal.dob(1), animal.dob(2), animal.dob(3));
            end
            
            if ~isempty(animal.protocol)
                key_subj.protocol = animal.protocol;
            end
            
            if ~isempty(animal.initWeight)
                key_subj.initial_weight = animal.initWeight;
            end
            
            
            if ~isempty(animal.actItems)
                for i_act = 1:length(animal.actItems)
                    key_act = struct(...
                        'user_id', animal.owner, ...
                        'subject_id', animal.ID);

                    key_act.act_item = animal.actItems{i_act};
                    inserti(subject.SubjectActItem, key_act)
                end
            end
            if ~isempty(animal.genotype)
                key_subj.line = animal.genotype;
            else
                key_subj.line = 'Unknown';
            end
            inserti(subject.Subject, key_subj)
            
            % death information
           
            if ~isempty(animal.status) && strcmp(animal.status{end}, 'Dead')
                key_death.subject_id = animal.ID;
                key_death.user_id = animal.owner;
                death_date = animal.effective{end};
                key_death.death_date = sprintf('%d-%02d-%02d', death_date(1), death_date(2), death_date(3));
                inserti(subject.Death, key_death)
            end
            
            % caging information
            key_cage.cage = animal.cage;
            if contains(animal.cage, 'Ben')
                key_cage.cage_owner = 'ben';
            elseif contains(animal.cage, 'SK')
                key_cage.cage_owner = 'sakoay';
            elseif contains(animal.cage, 'EN')
                key_cage.cage_owner = 'edward';
            elseif contains(animal.cage, 'LP')
                key_cage.cage_owner = 'lucas';
            elseif contains(animal.cage, 'Test')
                key_cage.cage_owner = 'testuser';
            else
                key_cage.cage_owner = 'unknown';
            end
            inserti(subject.Cage, key_cage)
            
            key_caging_status = struct(...
                'subject_id', animal.ID, ...
                'user_id', animal.owner,...
                'cage', animal.cage);
            inserti(subject.CagingStatus, key_caging_status)
            
            % ingest SubjectStatus
            key_status = struct(...
                'subject_id', animal.ID, ...
                'user_id', animal.owner);
            if ~isempty(animal.status)
                for istatus = 1:length(animal.status)
                    
                    key_status.subject_status = animal.status{istatus}.string;
                    
                    date = animal.effective{istatus};
                    key_status.effective_date = sprintf('%d-%02d-%02d', date(1), date(2), date(3));
                    key_status.water_per_day = animal.waterPerDay{istatus};
                    key_status.schedule = strjoin(animal.techDuties{istatus}.string, '/');
                    inserti(action.SubjectStatus, key_status)
                end
            end
                
        end
    end
end
