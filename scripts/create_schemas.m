
schemas = {'lab', 'reference', 'task', 'subject', 'action', 'acquisition', 'behavior'};

for ischema = schemas
    try
        query(dj.conn, sprintf('CREATE SCHEMA `u19_%s`', ischema{:}))
    catch
        fprintf(sprintf('Schema %s exists.\n', ischema{:}))
    end
end