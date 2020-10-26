function location_info =  check_location(location)
%CHECK_LOCATION, check if location already in the database and insert it if it was not there
%Input
% location       = name of the location to check
%Output
% location_info  = data for given location

% Check for location in db
keylocation.location = location;
location_info = fetchn(lab.Location & keylocation, '*');
if ~isempty(location_info)
    return
else
 % If location doesn't exist insert it (in the future have a "test location for everything)
   inserti(lab.Location, location)
   location_info(1).location = location;
end

