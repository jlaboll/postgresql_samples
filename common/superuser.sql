-- Silence output
\ir quiet_on.sql

-- Set variables
SELECT current_setting('spike.pg_role') AS role_name, current_setting('spike.pg_role_password') AS role_password
\gset

SELECT NULLIF(:'role_name', '') IS NOT NULL AND NULLIF(:'role_password', '') IS NOT NULL AS can_create_role
\gset

-- Create role if possible and set echo message
\if :can_create_role
	SELECT 'CREATE USER ' || :'role_name' || ' WITH PASSWORD ' || quote_literal(:'role_password') || ' SUPERUSER'
	\gexec
	SELECT 'SET spike.echo_message TO ' || quote_literal('Superuser role "' || :'role_name' || '" created, use password "' || :'role_password' || '" for PSQL')
	\gexec
\else 
	SET spike.echo_message TO 'Role name config is not set, exiting';
\endif

-- Resume output
\ir quiet_off.sql

-- Echo
\ir echo.sql

-- Silence output
\ir quiet_on.sql