-- builtin commands
-- describe relations
\d
\d+ a_table
\dS+

-- describe roles and members
\du

-- connect to another database
\c new_database

-- list all databases
\l

-- coalesce() will use the value if exists, if null use specified string
SELECT username,
    coalesce(ip, 'no IP')
FROM logs;

-- round dates to specified precision
SELECT date_trunc('day', now());