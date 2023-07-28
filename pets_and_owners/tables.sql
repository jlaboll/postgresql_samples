-- Create tables
CREATE TABLE IF NOT EXISTS common.setting (
	id serial CONSTRAINT common_setting_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	key text DEFAULT ''::text NOT NULL,
	set_boolean boolean DEFAULT FALSE,
	set_date date DEFAULT NULL::date,
	set_text text DEFAULT NULL::text,
	set_integer integer DEFAULT NULL::integer
);

CREATE TABLE IF NOT EXISTS common.country (
	id serial CONSTRAINT common_country_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	name text DEFAULT ''::text NOT NULL
);

CREATE TABLE IF NOT EXISTS common.region (
	id serial CONSTRAINT common_region_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	name text DEFAULT ''::text NOT NULL,
	common_country_fk integer CONSTRAINT common_region_common_country_fk REFERENCES common.country ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS owner.address (
	id serial CONSTRAINT owner_address_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	common_region_fk integer CONSTRAINT owner_address_common_region_fk REFERENCES common.region ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	street_line_1 text DEFAULT ''::text NOT NULL,
	street_line_2 text DEFAULT ''::text NOT NULL,
	street_line_3 text DEFAULT ''::text NOT NULL,
	city text DEFAULT ''::text NOT NULL,
	postal_code text 
);

CREATE TABLE IF NOT EXISTS owner.entity (
	id serial CONSTRAINT owner_entity_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	owner_address_fk integer CONSTRAINT owner_entity_owner_address_fk REFERENCES owner.address ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS owner.contact (
	id serial CONSTRAINT owner_contact_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	preferred boolean DEFAULT FALSE,
	owner_entity_fk integer CONSTRAINT owner_contact_owner_entity_fk REFERENCES owner.entity ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS owner.email (
	id serial CONSTRAINT owner_email_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	email_address text DEFAULT ''::text NOT NULL,
	owner_contact_fk integer CONSTRAINT owner_email_owner_contact_fk REFERENCES owner.contact ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS owner.phone (
	id serial CONSTRAINT owner_phone_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	phone_number text DEFAULT ''::text NOT NULL,
	owner_contact_fk integer CONSTRAINT owner_email_owner_contact_fk REFERENCES owner.contact ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS owner.individual (
	id serial CONSTRAINT owner_individual_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	first_name text DEFAULT ''::text NOT NULL,
	middle_name text DEFAULT ''::text NOT NULL,
	last_name text DEFAULT ''::text NOT NULL,
	owner_entity_fk integer CONSTRAINT owner_individual_owner_entity_fk REFERENCES owner.entity ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS owner.group (
	id serial CONSTRAINT owner_group_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	name text DEFAULT ''::text NOT NULL,
	owner_entity_fk integer CONSTRAINT owner_group_owner_entity_fk REFERENCES owner.entity ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS pet.type (
	id serial CONSTRAINT pet_type_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	name text DEFAULT ''::text NOT NULL
);

CREATE TABLE IF NOT EXISTS pet.breed (
	id serial CONSTRAINT pet_breed_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	name text DEFAULT ''::text NOT NULL,
	pet_type_fk integer CONSTRAINT pet_breed_pet_type_fk REFERENCES pet.type ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS pet.entity (
	id serial CONSTRAINT pet_entity_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	name text DEFAULT ''::text NOT NULL,
	birthday date DEFAULT NOW()::date NOT NULL,
	historical boolean DEFAULT FALSE,
	pet_breed_fk integer CONSTRAINT pet_entity_pet_breed_fk REFERENCES pet.breed ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);

CREATE TABLE IF NOT EXISTS pet_owner.entity_link (
	id serial CONSTRAINT pet_owner_entity_link_pk PRIMARY KEY,
	created date DEFAULT NOW()::date NOT NULL,
	modified date DEFAULT NOW()::date NOT NULL,
	pet_entity_fk integer CONSTRAINT pet_owner_entity_link_pet_entity_fk REFERENCES pet.entity ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	owner_entity_fk integer CONSTRAINT pet_owner_entity_link_owner_entity_fk REFERENCES owner.entity ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
