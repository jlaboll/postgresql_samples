INSERT INTO common.setting(key, set_text) VALUES ('folding_character', E'\r');

INSERT INTO common.country 	(name 				)
VALUES 						('United States'	),
							('Canada'			),
							('Mexico'			),
							('United Kingdom'	),
							('Brazil'			),
							('France'			),
							('Germany'			),
							('Spain'			),
							('Australia'		);

SELECT id AS country_id FROM common.country WHERE name ILIKE 'United States'
\gset

INSERT INTO common.region 	(name, 						common_country_fk 	)
VALUES 						('Alaska', 					:country_id 		),
							('Alabama', 				:country_id 		),
							('Arkansas', 				:country_id 		),
							('Arizona', 				:country_id 		),
							('California', 				:country_id 		),
							('Colorado', 				:country_id 		),
							('Connecticut', 			:country_id 		),
							('District of Columbia', 	:country_id 		),
							('Delaware', 				:country_id 		),
							('Florida', 				:country_id 		),
							('Georgia', 				:country_id 		),
							('Hawaii', 					:country_id 		),
							('Iowa', 					:country_id 		),
							('Idaho', 					:country_id 		),
							('Illinois', 				:country_id 		),
							('Indiana', 				:country_id 		),
							('Kansas', 					:country_id 		),
							('Kentucky', 				:country_id 		),
							('Louisiana', 				:country_id 		),
							('Massachusetts', 			:country_id 		),
							('Maryland', 				:country_id 		),
							('Maine', 					:country_id 		),
							('Michigan', 				:country_id 		),
							('Minnesota', 				:country_id 		),
							('Missouri', 				:country_id 		),
							('Mississippi', 			:country_id 		),
							('Montana', 				:country_id 		),
							('North Carolina', 			:country_id 		),
							('North Dakota', 			:country_id 		),
							('Nebraska', 				:country_id 		),
							('New Hampshire', 			:country_id 		),
							('New Jersey', 				:country_id 		),
							('New Mexico', 				:country_id 		),
							('Nevada', 					:country_id 		),
							('New York', 				:country_id 		),
							('Ohio', 					:country_id 		),
							('Oklahoma', 				:country_id 		),
							('Oregon', 					:country_id 		),
							('Pennsylvania', 			:country_id 		),
							('Puerto Rico', 			:country_id 		),
							('Rhode Island', 			:country_id 		),
							('South Carolina', 			:country_id 		),
							('South Dakota', 			:country_id 		),
							('Tennessee', 				:country_id 		),
							('Texas', 					:country_id 		),
							('Utah', 					:country_id 		),
							('Virginia', 				:country_id 		),
							('Vermont', 				:country_id 		),
							('Washington', 				:country_id 		),
							('Wisconsin', 				:country_id 		),
							('West Virginia', 			:country_id 		),
							('Wyoming', 				:country_id 		);

SELECT id AS country_id FROM common.country WHERE name ILIKE 'Canada'
\gset

INSERT INTO common.region 	(name, 							common_country_fk 	)
VALUES 						('Ontario', 					:country_id 		),
							('Quebec', 						:country_id 		),
							('Nova Scotia', 				:country_id 		),
							('New Brunswick', 				:country_id 		),
							('Manitoba', 					:country_id 		),
							('British Columbia', 			:country_id 		),
							('Prince Edward Island', 		:country_id 		),
							('Saskatchewan', 				:country_id 		),
							('Alberta', 					:country_id 		),
							('Newfoundland and Labrador', 	:country_id 		),
							('Northwest Territories', 		:country_id 		),
							('Yukon', 						:country_id 		),
							('Nunavut', 					:country_id 		);

INSERT INTO pet.type 	(name 			)
VALUES 					('Dog'			),
						('Cat'			),
						('Hedgehog'		),
						('Guinea Pig'	);

SELECT id AS type_id FROM pet.type WHERE name ILIKE 'Dog'
\gset

INSERT INTO pet.breed 	(name, 				pet_type_fk )
VALUES 					('Dachshund', 		:type_id 	),
						('German Shepherd', :type_id 	),
						('Beagle',	 		:type_id 	),
						('Shiba Inu', 		:type_id 	);

SELECT id AS type_id FROM pet.type WHERE name ILIKE 'Cat'
\gset

INSERT INTO pet.breed 	(name, 					pet_type_fk )
VALUES 					('Siamese', 			:type_id 	),
						('American Shorthair', 	:type_id 	),
						('Abyssinian',	 		:type_id 	),
						('Burmese', 			:type_id 	);

SELECT id AS type_id FROM pet.type WHERE name ILIKE 'Hedgehog'
\gset

INSERT INTO pet.breed 	(name, 					pet_type_fk )
VALUES 					('Four-toed', 			:type_id 	),
						('Long-eared', 			:type_id 	),
						('European',	 		:type_id 	);

SELECT id AS type_id FROM pet.type WHERE name ILIKE 'Guinea Pig'
\gset

INSERT INTO pet.breed 	(name, 					pet_type_fk )
VALUES 					('Abyssinian', 			:type_id 	),
						('Teddy', 				:type_id 	),
						('American',	 		:type_id 	),
						('Texel',	 			:type_id 	),
						('Rex',	 				:type_id 	),
						('Satin',	 			:type_id 	);

SELECT cc.id AS country_id, cr.id AS region_id FROM common.country cc JOIN common.region cr ON cr.common_country_fk = cc.id WHERE cc.name ILIKE 'United States' AND cr.name ILIKE 'Illinois'
\gset 

INSERT INTO owner.address 	(street_line_1, 	street_line_2, 	street_line_3, 	city, 		postal_code, 	common_region_fk 	) 
VALUES 						('123 Maple Ave.', 	'Apt. 101', 	'', 			'Chicago', 	'60505', 		:region_id 			)
RETURNING id AS address_id 
\gset

INSERT INTO owner.entity 	(owner_address_fk  	)
VALUES 						(:address_id 		)
RETURNING id AS owner_id 
\gset 

INSERT INTO owner.contact 	(preferred, 	owner_entity_fk 	)
VALUES 						(TRUE, 		:owner_id 			),
							(FALSE, 	:owner_id 			);

INSERT INTO owner.phone (phone_number, 		owner_contact_fk  																			)
VALUES 					('(123) 787-2323', 	(SELECT id FROM owner.contact WHERE preferred = TRUE AND owner_entity_fk = :owner_id LIMIT 1)	);

INSERT INTO owner.email (email_address, 		owner_contact_fk  																				)
VALUES 					('sample@email.com', 	(SELECT id FROM owner.contact WHERE preferred = FALSE AND owner_entity_fk = :owner_id LIMIT 1)	);

INSERT INTO owner.individual 	(first_name, 	middle_name, 	last_name, 	owner_entity_fk	)
VALUES 							('Jasen', 		'Matthew', 		'LaBolle', 	:owner_id		);

INSERT INTO pet.entity 	(name, 			birthday, 				historical,		pet_breed_fk 																																		)
VALUES 					('Tootsie', 	'2009-10-05'::date, 	TRUE,			(SELECT id FROM pet.breed WHERE name ILIKE 'Beagle' LIMIT 1)																						),
						('Doritio', 	'2017-01-10'::date, 	TRUE,			(SELECT id FROM pet.breed WHERE name ILIKE 'Four-toed' LIMIT 1)																						),
						('Penelope', 	'2020-08-12'::date, 	FALSE,			(SELECT id FROM pet.breed WHERE name ILIKE 'Four-toed' LIMIT 1)																						),
						('S''mores', 	'2021-06-01'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'American' LIMIT 1)	),
						('Cookie', 		'2021-06-03'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'Satin' LIMIT 1)		),
						('Butterscotch','2021-10-15'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'American' LIMIT 1)	),
						('Reggie', 		'2021-11-20'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'Abyssinian' LIMIT 1)	),
						('Vanilla', 	'2023-02-14'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'American' LIMIT 1)	),
						('Boba', 		'2023-02-14'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'American' LIMIT 1)	),
						('Queso', 		'2023-04-11'::date, 	FALSE,			(SELECT pb.id FROM pet.type pt JOIN pet.breed pb ON pt.id = pb.pet_type_fk WHERE pt.name ILIKE 'Guinea Pig' AND pb.name ILIKE 'Abyssinian' LIMIT 1)	);

DO $$
	DECLARE 
		pet_entity_id integer;
		owner_entity_id integer;
	BEGIN
		SELECT owner_entity_fk FROM owner.individual WHERE first_name ILIKE 'Jasen' AND last_name ILIKE 'LaBolle' INTO owner_entity_id;

		IF NOT FOUND THEN 
			RETURN;
		END IF;

		INSERT INTO pet_owner.entity_link 	(
			pet_entity_fk, 
			owner_entity_fk
		) SELECT 
			id, 
			owner_entity_id
		FROM pet.entity;
	END;
$$;