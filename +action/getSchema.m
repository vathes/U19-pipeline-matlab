function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'action', 'pni_action');
end
obj = schemaObject;
end
