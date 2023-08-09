\ir ../common/quiet_on.sql
\o sample_export.csv

COPY (
	WITH owner_info AS (
		SELECT 
			oe.id AS owner_entity_id,
			owner.owner_description(oe.id) AS owner_description,
			owner.address_pretty(oa.*, owner.owner_description(oe.id), FALSE) AS owner_full_address,
			owner.contact_information(oe.id) AS owner_contact_information,
			pet.pet_description(pe.*) AS pet
		FROM owner.entity oe 
		JOIN owner.address oa
			ON oe.owner_address_fk = oa.id
		JOIN pet_owner.entity_link poel
			ON oe.id = poel.owner_entity_fk
		JOIN pet.entity pe
			ON poel.pet_entity_fk = pe.id
	) SELECT 
		oi.owner_entity_id,
		oi.owner_description,
		oi.owner_full_address,
		oi.owner_contact_information,
		string_agg(oi.pet, ' | ') AS pets
	FROM owner_info oi 
	GROUP BY 
		oi.owner_entity_id,
		oi.owner_description,
		oi.owner_full_address,
		oi.owner_contact_information
) TO STDOUT WITH CSV HEADER;

\o
\ir ../common/quiet_off.sql