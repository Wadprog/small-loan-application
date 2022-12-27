DROP FUNCTION IF EXISTS fn_register_entities;
DELIMITER $$
CREATE Function fn_register_entities
(
    first_name TEXT,
    last_name TEXT,
    gender TEXT
) 
RETURNS INTEGER
MODIFIES SQL DATA
DETERMINISTIC
BEGIN
	DECLARE last_entity INT;
    
    INSERT INTO Entities (first_name, last_name,gender) 
    VALUES (first_name,last_name,gender);
 SET last_entity = LAST_INSERT_ID();
RETURN last_entity;
END 
$$
DELIMITER ;