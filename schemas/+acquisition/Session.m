%{
# General information of a session
-> subject.Subject
session_date                : date                          # date of experiment
session_number              : int                           # number
---
session_start_time          : datetime                      # start time
session_end_time=null       : datetime                      # end time
(session_location) -> lab.Location
-> task.TaskLevelParameterSet
stimulus_bank = ''          : varchar(255)                  # path to the function to generate the stimulus
stimulus_commit = ''        : varchar(64)                   # git hash for the version of the function
stimulus_set                : tinyint                       # an integer that describes a particular set of stimuli in a trial
session_performance         : float                         # percentage correct on this session
session_narrative = ''      : varchar(512)                  # descriptive string
session_protocol=null       : varchar(255)                  # function and parameters to generate the stimulus
session_code_version=null   : blob                          # code version of the stimulus, usually two numbers "maze_version=2.1, code_version = 4.0". In the future: a githash?
%}

classdef Session < dj.Imported
    
    methods(Access=protected)
        
        function makeTuples(self, key)
            
            %Get behavioral file to load
            data_dir = fetch(acquisition.SessionStarted & key, {'task', 'remote_path_behavior_file'});
            
            if strcmp(data_dir.task, 'Towers')
                getLocalPath(data_dir.remote_path_behavior_file)
                data = load(data_dir, 'log');
                log = data.log;
                self.insertSessionFromFile_Towers(key, log);
            end
                        
        end    
    end
    
    
    methods
        function insertSessionFromFile_Towers(self,key,log)
            % Insert session record from behavioralfile in towersTask
            % Called at the end of training or when populating session
            % Input
            % self         = acquisition.Session instance
            % key  = structure with required fields: (subject_fullname, date, session_no)
            % log          = behavioral file as stored in Virmen
            
                                    
            key.session_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.start(1), log.session.start(2), log.session.start(3), log.session.start(4), log.session.start(5));
            key.session_end_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.end(1), log.session.end(2), log.session.end(3), log.session.end(4), log.session.end(5));
            
            key.stimulus_bank = log.block.stimulusBank;
            key.task = 'Towers';
            key.session_location = log.version.rig.rig;
            key.set_id = 1;
            
            
            %Get session_performance
            correct_number = 0;
            counter = 0;
            for block_idx = 1:length(log.block)
                trialstruct = log.block(block_idx);
                
                %Get stimulus_bank and level from last block of session
                if block_idx == length(log.block)
                    key.stimulus_bank = trialstruct.stimulusBank;
                    key.level = trialstruct.mainMazeID;
                end
                
                %Calculate correct trials for block
                for itrial = 1:length(trialstruct.trial)
                    trial = trialstruct.trial(itrial);
                    if isempty(trial.trialType)
                        break;
                    end
                    correct_number = correct_number + strcmp(trial.trialType.char, trial.choice.char);
                    counter = counter + 1;
                end
            end
            if counter ~= 0
                key.session_performance = correct_number*100 / counter;
            else
                key.session_performance = 0;
            end
            
            %Prepare session_protocol
            session_protocol = [ func2str(log.version.code) '.m' ' ', ...
                log.version.name '.mat' ' ', ...
                func2str(log.animal.protocol)];
            
            key.session_protocol = session_protocol;
            
            %Get commit version of session
            commit = strsplit(log.version.repository);
            commit = commit{1};
            key.stimulus_commit   = commit;
            
            
            %Session code_version
            key.session_code_version = {log.version.mazeVersion, log.version.codeVersion};
            
            %and insert this session:
            insert(acquisition.Session, key)
            
        end
        
    end
end