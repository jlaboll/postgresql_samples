CREATE OR REPLACE VIEW pet.pet_detail AS 
	SELECT
		pe.id,
		pe.name,
		pb.name AS breed,
		pt.name AS type,
		pe.birthday,
		pe.historical
	FROM pet.entity pe
	JOIN pet.breed pb
		ON pb.id = pe.pet_breed_fk
	JOIN pet.type pt
		ON pt.id = pb.pet_type_fk;


CREATE OR REPLACE VIEW owner.owner_detail AS
	SELECT
		oe.id,
		og.name AS group_name,
		oi.first_name,
		oi.middle_name,
		oi.last_name,
		oa.street_line_1,
		oa.street_line_2,
		oa.street_line_3,
		oa.city,
		cr.name AS region_name,
		oa.postal_code,
		cc.name AS country_name,
		array_agg(oce.email_address) AS email_addresses,
		array_agg(ocp.phone_number) AS phone_numbers
	FROM owner.entity oe
	LEFT OUTER JOIN owner.individual oi
		ON oe.id = oi.owner_entity_fk
	LEFT OUTER JOIN owner.group og
		ON oe.id = og.owner_entity_fk
	JOIN owner.address oa
		ON oa.id = oe.owner_address_fk
	JOIN common.region cr
		ON cr.id = oa.common_region_fk
	JOIN common.country cc
		ON cc.id = cr.common_country_fk
	LEFT OUTER JOIN owner.contact oc 
		ON oc.owner_entity_fk = oe.id
	LEFT OUTER JOIN owner.email oce
		ON oce.owner_contact_fk = oc.id
	LEFT OUTER JOIN owner.phone ocp
		ON ocp.owner_contact_fk = oc.id
	GROUP BY 
		oe.id,
		oi.first_name,
		oi.middle_name,
		oi.last_name,
		og.name,
		oa.street_line_1,
		oa.street_line_2,
		oa.street_line_3,
		oa.city,
		oa.postal_code,
		cr.name,
		cc.name;

CREATE OR REPLACE VIEW pet_owner.pet_owner_detail AS 
	SELECT
		poel.id, 
		ood.group_name,
		ood.first_name,
		ood.middle_name,
		ood.last_name,
		ood.street_line_1,
		ood.street_line_2,
		ood.street_line_3,
		ood.city,
		ood.region_name,
		ood.postal_code,
		ood.country_name,
		ood.email_addresses,
		ood.phone_numbers,
		ppd.name, 
		ppd.breed,
		ppd.type,
		ppd.birthday,
		ppd.historical
	FROM pet_owner.entity_link poel
	JOIN owner.owner_detail ood
		ON ood.id = poel.owner_entity_fk
	JOIN pet.pet_detail ppd
		ON ppd.id = poel.pet_entity_fk;