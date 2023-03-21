-- Caller: admin or guests
-- Senario: return the book for the guest
-- Function: return the book, update the database
-- Input: user_id, ISBN, copy_ID, borrowing_ID

DROP PROCEDURE IF EXISTS book_return;

DELIMITER //
CREATE PROCEDURE book_return(
    IN user_id            BIGINT, 
    IN ISBN               VARCHAR(20),
    IN copy_ID            BIGINT
)

BEGIN
    -- update the copy availability
    UPDATE COPY
    SET COPY.availability = 1
    WHERE COPY.copy_ID = copy_ID AND COPY.ISBN = ISBN;

    -- update the return date in borrowing
    UPDATE Borrowing
    SET return_date = (SELECT DATE(NOW()))
    WHERE ((Borrowing.copy_ID, Borrowing.ISBN) = (copy_ID, ISBN)) and (Borrowing.return_date is null);

    -- update guest information
    UPDATE Guest 
    SET Guest.remaining_credit = Guest.remaining_credit + 1
    WHERE  Guest.ID = user_id;
     
END //
DELIMITER ;
