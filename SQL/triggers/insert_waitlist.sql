DELIMITER //

CREATE TRIGGER insert_waitlist BEFORE INSERT ON Waitlist
FOR EACH ROW
BEGIN
  SET NEW.priority = (
    SELECT IFNULL(MAX(Waitlist.priority), 0) + 1
    FROM Waitlist
    WHERE Waitlist.ISBN = NEW.ISBN
  );
END //

DELIMITER ;