function obj = getSchema
prefix = getenv('DB_PREFIX');
persistent schemaObject
if isempty(schemaObject)
    schemaObject = dj.Schema(dj.conn, 'acquisition', [prefix 'acquisition']);
end
obj = schemaObject;
end
