-- Caller: guests
-- Senario: after a guest searched a book, the guest borrow the book from the application by himself/herself
-- Function: check if the guest can borrow the given book and there is available copy, and update the corresponding tables
-- Input: user id, ISBN, borrow days
-- Output: whether there is enough credit for the guest, and whether there is enough copies of the selected book


DELIMITER //

CREATE PROCEDURE borrow_via_guest (
    IN user_id            INT, 
    IN ISBN               VARCHAR(20),
    OUT enough_credit     BOOLEAN,
    OUT copy_available    BOOLEAN
)

proc_label: BEGIN
   -- check if user still has credit to borrow
   SET enough_credit =
   CASE 
        WHEN (SELECT Guest.remaining_credit
                FROM Guest
                WHERE Guest.ID = user_id
                AND Guest.is_activated = TRUE ) >= 1
		THEN TRUE
        ELSE FALSE
	END;

    -- check if the book has available copy
    SET copy_available = 
    CASE
        WHEN (
            SELECT COUNT(*)
            FROM Copy
            WHERE Copy.ISBN = ISBN
            AND Copy.availability = TRUE
        ) >= 1 
        THEN TRUE
        ELSE  FALSE
	END;


    -- if not enough credit or copy not available, then exist the procedure
    IF (enough_credit = FALSE OR copy_available = FALSE) THEN
        LEAVE proc_label;
    END IF;
    -- otherwise, we update the tables for this borrow
    SET @new_credit = (
		SELECT Guest.remaining_credit - 1
        FROM Guest
        WHERE Guest.ID = user_id);

    -- find a copy of the chosen book
    SET @copy_ID = (
        SELECT Copy.copy_ID
        FROM Copy
        WHERE Copy.ISBN = ISBN
        AND Copy.availability = TRUE
        LIMIT 1
    );

    -- update guest remaining credit
    UPDATE GUEST
    SET remaining_credit = @new_credit
    WHERE GUEST.ID = user_id;

    -- update availability in Copy table
    UPDATE COPY
    SET COPY.availability = FALSE
    WHERE COPY.ISBN = ISBN AND COPY.copy_ID = @copy_ID;

    -- update the current storing amount of the Bookshelf table
    UPDATE Bookshelf
    SET Bookshelf.current_amount = Bookshelf.current_amount - 1
    WHERE Bookshelf.ID = (
        SELECT Copy.bookshelf_ID
        FROM Copy
        WHERE Copy.ISBN = ISBN
        AND Copy.copy_ID = @copy_ID
    );
	
    -- insert a record into BORROWING table
    INSERT INTO Borrowing
    VALUES(ISBN, @copy_ID, 0, CURDATE(), NULL, CURDATE(), 0, user_id);
    
  END//
DELIMITER ;
