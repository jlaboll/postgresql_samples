-- Echo the current spike_echo_message setting
SELECT current_setting('spike.echo_message') AS message
\gset 

SELECT NULLIF(:'message', '') IS NOT NULL AS can_echo
\gset

\if :can_echo
	\echo
	\echo --------------------
	\echo :message
	\echo --------------------
	\echo
\endif