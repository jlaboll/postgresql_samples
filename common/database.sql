-- Silence output
\ir quiet_on.sql

-- Set variables
SELECT current_setting('spike.pg_database') AS db_name, current_setting('spike.pg_role') AS role_name
\gset

SELECT NULLIF(:'db_name', '') IS NOT NULL AND EXISTS (SELECT TRUE FROM pg_roles WHERE rolname = :'role_name') AS can_create_db
\gset

-- Create database if possible and set echo message
\if :can_create_db
	SELECT 'CREATE DATABASE ' || :'db_name' || ' WITH OWNER ' || :'role_name' || ' ENCODING ''UTF-8'''
	\gexec
	SELECT 'SET spike.echo_message TO ' || quote_literal('Project database ' || :'db_name' || ' created')
	\gexec
\else 
	SET spike.echo_message TO 'Either database name config is not set or expected pg_role does not exist, exiting';
\endif

-- Resume output
\ir quiet_off.sql

-- Echo message
\ir echo.sql 

-- Silence output
\ir quiet_on.sql