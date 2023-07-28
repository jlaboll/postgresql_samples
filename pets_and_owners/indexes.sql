-- Create indexes
CREATE UNIQUE INDEX common_setting_uindex 
	ON common.setting (id);

CREATE UNIQUE INDEX common_setting_key_uindex 
	ON common.setting (key);

CREATE UNIQUE INDEX common_country_uindex 
	ON common.country (id);

CREATE UNIQUE INDEX common_country_name_uindex 
	ON common.country (name);

CREATE UNIQUE INDEX common_region_uindex 
	ON common.region (id);

CREATE UNIQUE INDEX common_region_name_common_country_fk_uindex 
	ON common.region (name, common_country_fk);

CREATE UNIQUE INDEX owner_address_uindex 
	ON owner.address (id);

CREATE UNIQUE INDEX owner_entity_uindex 
	ON owner.entity (id);

CREATE UNIQUE INDEX owner_contact_uindex 
	ON owner.contact (id);

CREATE UNIQUE INDEX owner_email_uindex 
	ON owner.email (id);

CREATE UNIQUE INDEX owner_phone_uindex 
	ON owner.phone (id);

CREATE UNIQUE INDEX owner_individual_uindex 
	ON owner.individual (id);

CREATE UNIQUE INDEX owner_group_uindex 
	ON owner.group (id);

CREATE UNIQUE INDEX pet_type_uindex 
	ON pet.type (id);

CREATE UNIQUE INDEX pet_type_name_uindex 
	ON pet.type (name);

CREATE UNIQUE INDEX pet_breed_uindex 
	ON pet.breed (id);

CREATE UNIQUE INDEX pet_breed_name_pet_type_fk_uindex 
	ON pet.breed (name, pet_type_fk);

CREATE UNIQUE INDEX pet_entity_uindex 
	ON pet.breed (id);

CREATE UNIQUE INDEX pet_owner_entity_link_uindex 
	ON pet_owner.entity_link (id);

CREATE UNIQUE INDEX pet_owner_entity_link_fks_uindex 
	ON pet_owner.entity_link (pet_entity_fk, owner_entity_fk);