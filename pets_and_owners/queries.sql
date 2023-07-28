SELECT
	*
FROM common.country
LIMIT 5;

SELECT
	* 
FROM pet.entity
LIMIT 5;

SELECT
	pet.pet_description(pet.entity.*) AS pet_description
FROM pet.entity;

SELECT
	owner.owner_description(owner.entity.id) AS owner_description,
	owner.address_pretty(owner.address.*, owner.owner_description(owner.entity.id), TRUE) AS owner_address_block
FROM owner.entity
JOIN owner.address
	ON owner.entity.owner_address_fk = owner.address.id;

SELECT
	* 
FROM pet_owner.pet_owner_detail;