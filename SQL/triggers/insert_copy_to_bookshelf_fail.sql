DELIMITER //

CREATE TRIGGER insert_copy_to_bookshelf_success AFTER INSERT ON Copy
FOR EACH ROW
WHEN (
  SELECT Bookshelf.current_amount 
  FROM Bookshelf 
  WHERE Bookshelf.ID = NEW.bookshelf_ID
) + 1 > (
  SELECT Bookshelf.capacity 
  FROM Bookshelf
  WHERE WHERE Bookshelf.ID = NEW.bookshelf_ID
)
BEGIN
  ROLLBACK;
END //

DELIMITER ;