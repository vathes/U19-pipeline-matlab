function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'subject', 'pni_subject');
end
obj = schemaObject;
end
