-- Store the current user and database so we can reconnect later
SELECT current_database() AS current_db_name, CURRENT_USER AS current_db_user
\gset

-- Setup superuser and database
\ir superuser.sql
\ir database.sql

-- Connect to new database
\echo Switching to database postgres_jlaboll_spike as jlaboll
\c postgres_jlaboll_spike jlaboll