-- For the case that a guest bring a book to the front desk and wants to borrow the book.
-- The admin at the front-desk will help the guest to borrow the book, 
--   where the user, book, copy, and number of days of borrowing is known
CREATE PROCEDURE borrow_via_admin (
    IN [user_id]            INT, 
    IN [ISBN]               VARCHAR(20),
    IN [copy_ID]            INT,
    IN [borrow_days]        INT,
    OUT [enough_credit]     BOOLEAN
)
  proc_label: BEGIN
   -- check if user still has credit to borrow
	CASE
        WHEN IFNULL((
                SELECT [Guest].[remaining_credit]
                FROM [Guest]
                WHERE [Guest].[ID] = [user_id]
            ), 0
        ) >= 1 THEN TRUE
        ELSE FALSE
	END AS result INTO enough_credit;

    -- if not enough credit, then exist the procedure
    IF enough_credit = FALSE THEN
        LEAVE proc_label
    END IF

    -- otherwise, we update the tables for this borrow
    SET @new_credit = remaining_credit - 1;

    -- update guest remaining credit
    UPDATE GUEST
    SET remaining_credit = new_credit
    WHERE GUEST.ID = user_id;

    -- update availability in Copy table
    UPDATE COPY
    SET COPY.availability = FALSE
    WHERE COPY.ISBN = ISBN AND COPY.copy_ID = copy_ID;

    -- insert a record into BORROWING table
    SET @TODAY = CONVERT(DATE, GETDATE());
    SET @RETURN_DATE = CONVERT(DATE, GETDATE() + borrow_days);
    INSERT INTO BORROWING
    VALUES(ISBN, copy_ID, borrowing_ID, TODAY, NULL, RETURN_DATE, DEFAULT, user_id);


  END





-- For the case that guests borrow a book by themselves
--   where the user, book, and number of days of borrowing is known
--   and the procedure will check if the choosen book has an available copy
CREATE PROCEDURE borrow_via_guest (
    IN [user_id]            INT, 
    IN [ISBN]               VARCHAR(20),
    IN [borrow_days]        INT,
    OUT [enough_credit]     BOOLEAN,
    OUT [copy_available]    BOOLEAN
)
  proc_label: BEGIN
   -- check if user still has credit to borrow
	CASE
        WHEN IFNULL((
                SELECT [Guest].[remaining_credit]
                FROM [Guest]
                WHERE [Guest].[ID] = [user_id]
            ), 0
        ) >= 1 THEN TRUE
        ELSE FALSE
	END AS result INTO enough_credit;

    -- check if the book has available copy
    CASE
        WHEN (
            SELECT COUNT(*)
            FROM [Copy]
            WHERE [Copy].[ISBN] = [ISBN]
            AND [Copy].[availability] = TRUE
        ) >= 1 THEN TRUE
        ELSE FALSE
    END AS result INTO copy_available;

    -- if not enough credit or copy not available, then exist the procedure
    IF (enough_credit = FALSE OR copy_available = FALSE) THEN
        LEAVE proc_label
    END IF

    -- otherwise, we update the tables for this borrow
    SET @new_credit = remaining_credit - 1;

    -- update guest remaining credit
    UPDATE GUEST
    SET remaining_credit = new_credit
    WHERE GUEST.ID = user_id;

    -- update availability in Copy table
    UPDATE COPY
    SET COPY.availability = FALSE
    WHERE COPY.ISBN = ISBN AND COPY.copy_ID = copy_ID;

    -- insert a record into BORROWING table
    SET @TODAY = CONVERT(DATE, GETDATE());
    SET @RETURN_DATE = CONVERT(DATE, GETDATE() + borrow_days);
    INSERT INTO BORROWING
    VALUES(ISBN, copy_ID, borrowing_ID, TODAY, NULL, RETURN_DATE, DEFAULT, user_id);


  END