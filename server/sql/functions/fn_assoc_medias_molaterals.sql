DROP FUNCTION IF EXISTS fn_assoc_medias_colaterals;
DELIMITER $$
CREATE Function fn_assoc_medias_colaterals
(
    media_id INT,
    entity_id INT
) 
RETURNS INT
MODIFIES SQL DATA
DETERMINISTIC
BEGIN
    INSERT INTO MediasVSColaterals (media_id, entity_id) 
    VALUES (media_id, entity_id);
    RETURN 1;
END 
$$
DELIMITER ;