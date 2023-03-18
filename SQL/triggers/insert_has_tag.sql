DELIMITER //

CREATE TRIGGER insert_has_tag AFTER INSERT ON Has_tag
REFERENCING NEW ROW AS nrow
FOR EACH ROW
WHEN (
  SELECT COUNT(*)
  FROM Has_tag
  WHERE Has_tag.ISBN = nrow.ISBN AND Has_tag.tag_name = nrow.tag_name
) >= 1
BEGIN
  ROLLBACK;
END //

DELIMITER ;