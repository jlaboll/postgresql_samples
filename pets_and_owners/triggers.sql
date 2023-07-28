CREATE TRIGGER common_country_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON common.country FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER common_region_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON common.region FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();

CREATE TRIGGER owner_address_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.address FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER owner_entity_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.entity FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER owner_contact_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.contact FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER owner_email_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.email FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER owner_phone_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.phone FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER owner_individual_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.individual FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER owner_group_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON owner.group FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();

CREATE TRIGGER pet_type_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON pet.type FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER pet_breed_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON pet.breed FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();
CREATE TRIGGER pet_entity_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON pet.entity FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();

CREATE TRIGGER pet_owner_entity_link_common_insert_update_set_modified_date BEFORE INSERT OR UPDATE ON pet_owner.entity_link FOR EACH ROW EXECUTE PROCEDURE common.insert_update_set_modified_date();

CREATE TRIGGER owner_contact_owner_contact_insert_update_enforce_single_primary BEFORE INSERT OR UPDATE ON owner.contact FOR EACH ROW EXECUTE PROCEDURE owner.contact_insert_update_enforce_single_preferred();
