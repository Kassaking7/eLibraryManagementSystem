DELIMITER //

CREATE TRIGGER insert_borrowing BEFORE INSERT ON Borrowing
FOR EACH ROW
BEGIN
  SET NEW.borrowing_ID = (
    SELECT IFNULL(MAX(Borrowing.borrowing_ID), 0) + 1
    FROM Borrowing
    WHERE Borrowing.ISBN = Borrowing.ISBN
    AND Borrowing.copy_ID = Borrowing.copy_ID
  );
  SET NEW.borrow_date = CONVERT(DATE, CURDATE());
  SET NEW.return_deadline = CONVERT(DATE, ADDDATE(CURDATE(),15));
END //

DELIMITER ;