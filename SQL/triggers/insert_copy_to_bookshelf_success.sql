DELIMITER //

CREATE TRIGGER insert_copy_to_bookshelf_success AFTER INSERT ON Copy
FOR EACH ROW
WHEN 
BEGIN
  IF (
    SELECT Bookshelf.current_amount 
    FROM Bookshelf 
    WHERE Bookshelf.ID = NEW.bookshelf_ID
  ) + 1 <= (
    SELECT Bookshelf.capacity 
    FROM Bookshelf
    WHERE WHERE Bookshelf.ID = NEW.bookshelf_ID
  ) THEN 
    UPDATE Bookshelf 
    SET Bookshelf.current_amount = Bookshelf.current_amount + 1
    WHERE WHERE Bookshelf.ID = NEW.bookshelf_ID;
  END IF;
END //

DELIMITER ;