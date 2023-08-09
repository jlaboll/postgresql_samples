-- Silence output
\ir quiet_on.sql

-- Set vars
SELECT current_setting('spike.pg_role') AS role_name, current_setting('spike.pg_database') AS db_name
\gset

-- Set echo message
SET spike.echo_message TO 'Reconnecting to original database with original role';

-- Resume output
\ir quiet_off.sql 

-- Echo message
\ir echo.sql 

\c :current_db_name :current_db_user

-- Silence output
\ir quiet_on.sql

-- Set echo message
SET spike.echo_message TO 'Cleaning up sample database';

-- Resume output
\ir quiet_off.sql 

-- Echo message
\ir echo.sql 

SELECT 'DROP DATABASE IF EXISTS ' || :'db_name'
\gexec

-- Silence output
\ir quiet_on.sql

-- Set echo message
SET spike.echo_message TO 'Cleaning up sample role';

-- Resume output
\ir quiet_off.sql 

-- Echo message
\ir echo.sql 

-- Silenct output
\ir quiet_on.sql

SELECT 'DROP USER IF EXISTS ' || :'role_name'
\gexec

-- Resume output
\ir quiet_off.sql 