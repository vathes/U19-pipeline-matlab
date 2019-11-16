function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'acquisition', 'U19_acquisition');
end
obj = schemaObject;
end
