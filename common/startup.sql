-- Silence output
\ir quiet_on.sql 

-- Store the current user and database so we can reconnect later
SELECT current_database() AS current_db_name, CURRENT_USER AS current_db_user
\gset

-- Setup superuser and database
\ir superuser.sql
\ir database.sql

-- Set echo message
SELECT 'SET spike.echo_message TO ' || quote_literal('Switching to database ' || current_setting('spike.pg_database') || ' as ' || current_setting('spike.pg_role'))
\gexec

-- Resume output
\ir quiet_off.sql

-- Message STDOUT
\ir echo.sql

-- Silence output
\ir quiet_on.sql 

SELECT current_setting('spike.pg_role') AS role_name, current_setting('spike.pg_database') AS db_name
\gset

SELECT EXISTS (SELECT TRUE FROM pg_roles WHERE rolname = :'role_name') AND EXISTS (SELECT TRUE FROM pg_database WHERE datname = :'db_name') AS db_and_user_exist
\gset

-- Resume output
\ir quiet_off.sql

-- Connect to new database if the database and role exist
\if :db_and_user_exist 
	\c :db_name :role_name
	SELECT 'SET spike.pg_role TO ' || quote_literal(:'role_name')
	\gexec
	SELECT 'SET spike.pg_database TO ' || quote_literal(:'db_name')
	\gexec
\else 
	\quit
\endif