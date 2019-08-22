function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'action', 'U19_action');
end
obj = schemaObject;
end
