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

-- change logging options
ALTER database postgres SET log_min_duration_statement = '250ms';
ALTER DATABASE postgres SET log_statement = 'all';

-- list current connections sorted by type
SELECT count(*),
	   state
FROM pg_stat_activity
GROUP BY state;

-- coalesce() will use the value if exists, if null use specified string
SELECT username,
    coalesce(ip, 'no IP')
FROM logs;

-- round dates to specified precision
SELECT date_trunc('day', now());