function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'subject', 'U19_subject');
end
obj = schemaObject;
end
