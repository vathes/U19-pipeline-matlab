function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'acquisition', 'pni_acquisition');
end
obj = schemaObject;
end
