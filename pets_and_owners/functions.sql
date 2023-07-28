CREATE OR REPLACE FUNCTION common.insert_update_set_modified_date()
RETURNS trigger AS
$BODY$
	DECLARE
	BEGIN
		IF NEW.modified IS DISTINCT FROM NOW()::date THEN 
			NEW.modified := NOW()::date;
		END IF;

		RETURN NEW;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;

CREATE OR REPLACE FUNCTION owner.contact_insert_update_enforce_single_preferred()
RETURNS trigger AS
$BODY$
	DECLARE
	BEGIN
		IF NEW.preferred = FALSE THEN 
			RETURN NEW;
		END IF;

		IF TG_OP = 'UPDATE' THEN
			IF NEW.preferred = OLD.preferred THEN 
				RETURN NEW;
			END IF;
		END IF;

		UPDATE owner.contact SET preferred = FALSE WHERE owner_entity_fk = NEW.owner_entity_fk AND id <> NEW.id AND preferred = TRUE;

		RETURN NEW;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;

CREATE OR REPLACE FUNCTION common.get_folding_character()
RETURNS text AS
$BODY$
	SELECT COALESCE(
		(
			SELECT 
				NULLIF(set_text, '')
			FROM common.setting
			WHERE
				key ILIKE 'folding_character'
		),
		E'\r'
	);
$BODY$
LANGUAGE 'sql' IMMUTABLE
COST 100;

CREATE OR REPLACE FUNCTION pet.pet_description(pet_entity pet.entity)
RETURNS text AS 
$BODY$
	SELECT 
		pet_entity.name || ' - ' || pt.name || ', ' || pb.name
	FROM pet.breed pb
	JOIN pet.type pt
		ON pt.id = pb.pet_type_fk
	WHERE
		pb.id = pet_entity.pet_breed_fk;
$BODY$
LANGUAGE 'sql' IMMUTABLE
COST 100;

CREATE OR REPLACE FUNCTION pet.pet_description(pet_entity pet.entity)
RETURNS text AS 
$BODY$
	SELECT 
		pet_entity.name || ' - ' || pt.name || ', ' || pb.name
	FROM pet.breed pb
	JOIN pet.type pt
		ON pt.id = pb.pet_type_fk
	WHERE
		pb.id = pet_entity.pet_breed_fk;
$BODY$
LANGUAGE 'sql' IMMUTABLE
COST 100;

CREATE OR REPLACE FUNCTION owner.address_pretty(owner_address owner.address, full_name text DEFAULT ''::text, folding boolean DEFAULT FALSE)
RETURNS text AS 
$BODY$
	DECLARE 
		folding_char text := '';
		region_name text;
		country_name text;
	BEGIN
		IF folding THEN
			folding_char := common.get_folding_character();
		END IF;

		SELECT 
			cr.name,
			cc.name
		FROM common.region cr
		JOIN common.country cc
			ON cc.id = cr.common_country_fk
		WHERE 
			cr.id = owner_address.common_region_fk
		INTO region_name, country_name;

		RETURN CASE WHEN NULLIF(full_name, '') IS NOT NULL THEN 
				full_name || ' ' || folding_char
			ELSE 
				''
			END ||
			owner_address.street_line_1 || ' ' || folding_char ||
			CASE WHEN NULLIF(owner_address.street_line_2, '') IS NOT NULL THEN
				owner_address.street_line_2 || ' ' || folding_char
			ELSE 
				''
			END ||
			CASE WHEN NULLIF(owner_address.street_line_3, '') IS NOT NULL THEN
				owner_address.street_line_3 || ' ' || folding_char
			ELSE 
				''
			END ||
			owner_address.city || ' ' ||
			region_name || ', ' || 
			owner_address.postal_code || ' ' || folding_char ||
			country_name;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;

CREATE OR REPLACE FUNCTION owner.owner_description(owner_entity_id integer)
RETURNS text AS 
$BODY$
	SELECT 
		COALESCE(
			CASE 
				WHEN oi.id IS NOT NULL THEN 
					oi.first_name || ' ' || 
					CASE 
						WHEN NULLIF(oi.middle_name, '') IS NULL THEN 
							''
						ELSE 
							substring(oi.middle_name, 1, 1) || '. '
					END || oi.last_name 
				WHEN og.id IS NOT NULL THEN 
					og.name
				ELSE 
					NULL::text
			END,
			'Unknown'
		)
	FROM owner.entity oe
	LEFT OUTER JOIN owner.individual oi
		ON oe.id = oi.owner_entity_fk
	LEFT OUTER JOIN owner.group og
		ON oe.id = og.owner_entity_fk
	WHERE oe.id = owner_entity_id;
$BODY$
LANGUAGE 'sql' IMMUTABLE
COST 100;

CREATE OR REPLACE FUNCTION owner.contact_information(owner_entity_id integer, folding boolean DEFAULT FALSE)
RETURNS text AS 
$BODY$
	DECLARE 
		folding_char text := '';
		owner_contact_row record;
		contact_info text;
		return_contact_info text := '';
	BEGIN
		IF folding THEN 
			folding_char := common.get_folding_character();
		END IF;

		FOR owner_contact_row IN 
			WITH owner_emails AS (
				SELECT 
					oc.preferred,
					TRUE AS is_email,
					oce.email_address AS contact
				FROM owner.contact oc
				JOIN owner.email oce 
					ON oc.id = oce.owner_contact_fk
				WHERE 
					oc.owner_entity_fk = owner_entity_id AND
					NULLIF(oce.email_address, '') IS NOT NULL
			), owner_phones AS (
				SELECT 
					oc.preferred,
					FALSE AS is_email,
					ocp.phone_number AS contact
				FROM owner.contact oc
				JOIN owner.phone ocp 
					ON oc.id = ocp.owner_contact_fk
				WHERE 
					oc.owner_entity_fk = owner_entity_id AND
					NULLIF(ocp.phone_number, '') IS NOT NULL
			), owner_contact_union AS (
				SELECT 
					* 
				FROM owner_emails
				UNION SELECT 
					* 
				FROM owner_phones
			) SELECT 
				* 
			FROM owner_contact_union
			ORDER BY 
				preferred = FALSE
		LOOP
			IF owner_contact_row.is_email THEN 
				contact_info := 'E-Mail Address: ' || owner_contact_row.contact;
			ELSE 
				contact_info := 'Phone Number: ' || owner_contact_row.contact;
			END IF;

			IF owner_contact_row.preferred THEN 
				return_contact_info := 'Preferred ' || contact_info || '; ' || 
					CASE 
						WHEN NULLIF(return_contact_info, '') IS NOT NULL THEN 
							folding_char 
						ELSE 
							'' 
					END || return_contact_info;
			ELSE 
				return_contact_info := return_contact_info || folding_char || contact_info || '; ';
			END IF;
		END LOOP;

		RETURN return_contact_info;
	END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;