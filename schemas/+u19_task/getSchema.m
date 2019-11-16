function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'u19_task', 'u19_task');
end
obj = schemaObject;
end
