
% load the task information from the .mat file

% insert task.Parameter

key.parameter_category = 'maze';

for field_mazes = fieldnames(mazes)'
    key.parameter = field_mazes{:};
    inserti(task.Parameter, key)
end

key.parameter_category = 'criterion';

for field_criteria = fieldnames(criteria)'
    key.parameter = field_criteria{:};
    inserti(task.Parameter, key)
end

key.parameter_category = 'global settings';
for field_global = fieldnames(globalSettings)'
    key.parameter = field_global{:};
    inserti(task.Parameter, key)
end

key.parameter_category = 'other';
for other_par = others
    key.parameter = other_par{:};
    inserti(task.Parameter, key)
end

clear key

% insert task.TaskLevelParameterSet
key.task = 'Towers';

for iLevel = 1:11
    key.level = iLevel;
    inserti(task.TaskLevelParameterSet, key)
end

% insert task.TaskParameter
for iLevel = 1:11
    key.level = iLevel;
    
end

