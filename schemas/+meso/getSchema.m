function obj = getSchema
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'imaging', 'U19_imaging');
end
obj = schemaObject;
end
