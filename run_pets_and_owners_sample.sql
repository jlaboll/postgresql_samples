-- Silence output
\ir common/quiet_on.sql

-- Set configs
SET SESSION spike.pg_role TO 'jlaboll' ;
SET SESSION spike.pg_role_password TO 'foobar';
SET SESSION spike.pg_database TO 'postgres_jlaboll_spike';

-- Startup
\ir common/startup.sql

-- Create schemas
\ir pets_and_owners/schemas.sql 

-- Create tables
\ir pets_and_owners/tables.sql 

-- Create indexes
\ir pets_and_owners/indexes.sql 

-- Create functions
\ir pets_and_owners/functions.sql 

-- Create triggers
\ir pets_and_owners/triggers.sql 

-- Create views
\ir pets_and_owners/views.sql 

-- Create mock data
\ir pets_and_owners/mocks.sql

-- Run queries 
\ir pets_and_owners/queries.sql  

-- Run exports 
\ir pets_and_owners/exports.sql 

-- Cleanup spike 
\ir common/cleanup.sql 