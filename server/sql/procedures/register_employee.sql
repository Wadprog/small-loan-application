-- Stored procedure to insert employees 
DROP PROCEDURE IF EXISTS sp_register_employee;
DELIMITER $$
CREATE PROCEDURE sp_register_employee(
  IN employe_data JSON
)
BEGIN
  -- Declare iterator variable to use it later on in the loop
  DECLARE i INT DEFAULT 0;

  -- Retrieve values from JSON
  SET @first_name = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.first_name'));
  SET @last_name = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.last_name'));
  SET @gender = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.body'));
  SET @medias = JSON_EXTRACT(employe_data, '$.tags');
  SET @json = JSON_UNQUOTE(employe_data);
  -- Insert the entity 
  SET @last_entity = fn_register_entities(@first_name,@last_name,@gender);
  INSERT INTO Employees (entity_id) VALUES (@last_entity) ON DUPLICATE KEY UPDATE entity_id = @last_entity;
  -- Get medias length for the loop
  SET @medias_length = JSON_LENGTH(@medias);
  -- Execute loop over medias length
  WHILE i < @medias_length DO
    -- Retrieve current mewdia from tags array
    SET @media_detail = JSON_UNQUOTE(JSON_EXTRACT(employe_data, CONCAT('$.medias[',i,'].details')));
    SET @media_location_path = JSON_UNQUOTE(JSON_EXTRACT(employe_data, CONCAT('$.medias[',i,'].location_path')));
	SET @media_ext = JSON_UNQUOTE(JSON_EXTRACT(employe_data, CONCAT('$.medias[',i,'].ext')));
    -- Saving the media meta data
    SET @last_media =fn_register_medias(@media_detail,@media_ext,@media_location_path);
    -- Insert retrieved post_id and tag_id into post_tag
    SET @v= fn_assoc_medias_colaterals(@last_media, @last_entity);
    -- -- Add step to iterator
    SELECT i + 1 INTO i;
  END WHILE;

END $$
DELIMITER ;

call sp_register_employee('{"first_name":"wad","last_name":"val"}')