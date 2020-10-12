function insert_acq_session(acqsession_file, subject)
%INSERT_ACQ_SESSION insert u19_acquisition.session info when file is provided
%
% Input
% acqsession_file  = entire file path for towers task behavior file


load(acqsession_file,'log')

%primary key values
key_session.subject_fullname = subject;
key_session.session_date = sprintf('%d-%02d-%02d', log.session.start(1), log.session.start(2), log.session.start(3));
key_session.session_number = 0;

key_session.session_start_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.start(1), log.session.start(2), log.session.start(3), log.session.start(4), log.session.start(5));
key_session.session_end_time = sprintf('%d-%02d-%02d %02d:%02d:00', log.session.end(1), log.session.end(2), log.session.end(3), log.session.end(4), log.session.end(5));

key_session.stimulus_bank = log.block.stimulusBank;
key_session.task = 'Towers';
key_session.session_location = log.version.rig.rig;
key_session.set_id = 1;


%Get session_performance
correct_number = 0;
counter = 0;
for block_idx = 1:length(log.block)
    trialstruct = log.block(block_idx);
    
        %Get stimulus_bank and level from last block of session
        if block_idx == length(log.block)
            key_session.stimulus_bank = trialstruct.stimulusBank;
            key_session.level = trialstruct.mainMazeID;
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
key_session.session_performance = correct_number*100 / counter;

%Prepare session_protocol
session_protocol = [ func2str(log.version.code) '.m' ' ', ...
    log.version.name '.mat' ' ', ...
    func2str(log.animal.protocol)];

key_session.session_protocol = session_protocol;

%Get commit version of session
commit = strsplit(log.version.repository);
commit = commit{1};
key_session.stimulus_commit   = commit;


%Session code_version
key_session.session_code_version = {log.version.mazeVersion, log.version.codeVersion};

%and insert this session:
insert(acquisition.Session, key_session)

end

