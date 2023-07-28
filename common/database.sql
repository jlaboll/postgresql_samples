SELECT EXISTS (SELECT TRUE FROM pg_roles WHERE rolname = 'jlaboll') AS superuser_exists
\gset
\if :superuser_exists
	CREATE DATABASE postgres_jlaboll_spike WITH OWNER jlaboll ENCODING 'UTF-8';
	\echo Project database postgres_jlaboll_spike created
\else 
	\echo Expected role "jlaboll" does not exist, exiting
	\quit
\endif