
schemas = {'lab', 'reference', 'task', 'subject', 'action', 'acquisition', 'behavior'};

for ischema = schemas
    try
        query(dj.conn, sprintf('CREATE SCHEMA `pni_%s`', ischema{:}))
    catch
        fprintf(sprintf('Schema %s exists.\n', ischema{:}))
    end
end