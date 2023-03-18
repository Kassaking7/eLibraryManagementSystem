DELIMITER //

CREATE TRIGGER insert_has_tag AFTER INSERT ON Has_tag
FOR EACH ROW
WHEN (
  SELECT COUNT(*)
  FROM Has_tag
  WHERE Has_tag.ISBN = NEW.ISBN AND Has_tag.tag_name = NEW.tag_name
) >= 1
BEGIN
  ROLLBACK;
END //

DELIMITER ;