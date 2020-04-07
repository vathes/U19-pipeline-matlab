function obj = getSchema
% prefix = getenv('DB_PREFIX');
persistent schemaObject
if isempty(schemaObject)
%     schemaObject = dj.Schema(dj.conn, 'meso', [prefix 'meso']);
  schemaObject = dj.Schema(dj.conn, 'external', 'external');
end
obj = schemaObject;
end

