DELIMITER //

CREATE TRIGGER insert_copy_to_bookshelf_success AFTER INSERT ON Copy
REFERENCING NEW ROW AS nrow
FOR EACH ROW
WHEN (
  SELECT Bookshelf.current_amount 
  FROM Bookshelf 
  WHERE Bookshelf.ID = nrow.bookshelf_ID
) + 1 > (
  SELECT Bookshelf.capacity 
  FROM Bookshelf
  WHERE WHERE Bookshelf.ID = nrow.bookshelf_ID
)
BEGIN
  ROLLBACK;
END //

DELIMITER ;