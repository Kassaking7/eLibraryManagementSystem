DELIMITER //

CREATE TRIGGER insert_borrowing BEFORE INSERT ON Borrowing
FOR EACH ROW
BEGIN
  SET NEW.borrowing_ID = (
    SELECT IFNULL(MAX(Borrowing.borrowing_ID), 0) + 1
    FROM Borrowing
    WHERE Borrowing.ISBN = NEW.ISBN
    AND Borrowing.copy_ID = NEW.copy_ID
  );
  SET NEW.borrow_date = CURDATE();
  SET NEW.return_deadline = ADDDATE(CURDATE(),15);
END //

DELIMITER ;
