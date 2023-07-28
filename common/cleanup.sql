\echo Reconnecting to original database with original role
\c :current_db_name :current_db_user

\echo Cleaning up sample database
DROP DATABASE IF EXISTS postgres_jlaboll_spike;

\echo Cleaning up sample role
DROP USER IF EXISTS jlaboll;