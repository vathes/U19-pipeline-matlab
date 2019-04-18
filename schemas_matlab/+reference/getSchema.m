function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'reference', 'pni_reference');
end
obj = schemaObject;
end
