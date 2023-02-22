CREATE TRIGGER auto_increment_copy_id BEFORE INSERT ON Copy
FOR EACH ROW 
BEGIN
    SET NEW.copy_ID = (
       SELECT IFNULL(MAX(Copy.copy_ID), 0) + 1
       FROM Copy
       WHERE Copy.ISBN = NEW.ISBN
    );
END