DELIMITER //

CREATE TRIGGER insert_has_tag AFTER INSERT ON Has_tag
FOR EACH ROW
BEGIN
  IF (
    SELECT COUNT(*)
    FROM Has_tag
    WHERE Has_tag.ISBN = NEW.ISBN AND Has_tag.tag_name = NEW.tag_name
  ) >= 1 THEN
    SIGNAL sqlstate '45001' set message_text = "No way ! You cannot do this !";
  END IF;
END //

DELIMITER ;