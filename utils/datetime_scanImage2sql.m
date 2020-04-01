function date_out = datetime_scanImage2sql(date_in)

% date_out = datetime_scanImage2sql(date_in)
% converts to SQL datetime format from scan image header

fullLength = numel(date_in);
spaces     = [0 regexp(date_in,' ') fullLength];
date_out   = '';

for iEntry = 1:numel(spaces)-1
  if iEntry < 3
    date_out = [date_out date_in(spaces(iEntry)+1:spaces(iEntry+1)-1) '-'];
  elseif iEntry == 3
    date_out = [date_out date_in(spaces(iEntry)+1:spaces(iEntry+1)-1) ' '];
  elseif iEntry == numel(spaces)-1
    date_out = [date_out date_in(spaces(iEntry)+1:spaces(iEntry+1)-1)];
  else
    date_out = [date_out date_in(spaces(iEntry)+1:spaces(iEntry+1)-1) ':'];
  end
end