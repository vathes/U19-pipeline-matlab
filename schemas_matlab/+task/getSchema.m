function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'task', 'U19_task');
end
obj = schemaObject;
end
