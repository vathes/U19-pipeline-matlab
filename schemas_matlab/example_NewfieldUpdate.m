% Example Script to make a new field, and update the field



%% Make new field
addAttribute(acquisition.TowersBlock, 'block_performance: float  # performance in the current block')

%% update one field in TowersBlock
allBlocks = fetch(acquisition.TowersBlock); % Get the primary keys of all Blocks

for key_idx = 1:length(allBlocks)
    key = allBlocks(key_idx);
    disp(key_idx/length(allBlocks))
    trials = fetch(acquisition.TowersBlockTrial & key, '*'); % Get trials in blocks
    correct_counter = 0;
    for i = 1:length(trials)
        correct_counter = correct_counter + strcmp(trials(i).trial_type, trials(i).choice);
    end
    performance = correct_counter / length(trials);          % Calculate performance
    update(acquisition.TowersBlock & key, 'block_performance', performance) % Update entry
end