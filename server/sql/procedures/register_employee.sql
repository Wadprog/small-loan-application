-- Stored procedure to insert employees 
DROP PROCEDURE IF EXISTS sp_register_employee;
DELIMITER $$
CREATE PROCEDURE sp_register_employee(
  IN employe_data JSON
)
BEGIN
  -- Declare iterator variable to use it later on in the loop
  DECLARE i INT DEFAULT 0;
  DECLARE j INT DEFAULT 0;

  -- Retrieve values from JSON
  SET @first_name = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.first_name'));
  SET @last_name = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.last_name'));
  SET @gender = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.body'));
  SET @role_id = JSON_UNQUOTE(JSON_EXTRACT(employe_data, '$.role_id'));
  SET @medias = JSON_EXTRACT(employe_data, '$.medias');
  SET @json = JSON_UNQUOTE(employe_data);
  -- Insert the entity 
  SET @last_entity = fn_register_entities(@first_name,@last_name,@gender);
  INSERT INTO Employees (entity_id, role_id) VALUES (@last_entity,@role_id) ON DUPLICATE KEY UPDATE entity_id = @last_entity;
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
    INSERT INTO MediasEntities (media_id, entity_id) VALUES (@last_media,@last_entity) ON DUPLICATE KEY UPDATE last_media = @last_media;
    -- Associating the media with its tags 
    SET @tags = JSON_UNQUOTE(JSON_EXTRACT(employe_data, CONCAT('$.medias[',i,'].tags')));
	SET @tags_length = JSON_LENGTH(@tags);
	WHILE j < @tags_length DO
     SET @tag_id = JSON_UNQUOTE(JSON_EXTRACT(employe_data, CONCAT('$.medias[',i,'].tags[',j,']')));
     INSERT INTO MediasVsTags (media_id, tag_id) VALUES (@last_media,@tag_id) ON DUPLICATE KEY UPDATE last_media = @last_media;
     SELECT j + 1 INTO j;
	END WHILE;
    -- resetting inner iterator
    SELECT 0 INTO j;
    -- -- Add step to iterator
    SELECT i + 1 INTO i;
  END WHILE;

END $$
DELIMITER ;

call sp_register_employee(
'{
"first_name":"wad",
"last_name":"val",
"role_id":1, 
"medias":[
{
"details":"this is the first test media",
"ext":"image/jpeg",
"location_path": "/fotos"
} 
]
}'
)