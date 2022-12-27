DROP FUNCTION IF EXISTS fn_register_medias;
DELIMITER $$
CREATE Function fn_register_medias
(
    details TEXT,
    ext TEXT,
    location_path TEXT
) 
RETURNS INTEGER
MODIFIES SQL DATA
DETERMINISTIC
BEGIN
	DECLARE last_entity INT;
    
    INSERT INTO Medias (details, ext,location_path) 
    VALUES (details, ext,location_path);
 SET last_entity = LAST_INSERT_ID();
RETURN last_entity;
END 
$$
DELIMITER ;