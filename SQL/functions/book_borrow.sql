
CREATE PROCEDURE borrow_via_admin (
    IN [user_id]            INT, 
    IN [remaining_credit]   INT,
    IN [ISBN]               VARCHAR(20),
    IN [copy_ID]            INT,
    IN [borrow_days]        INT,
    OUT [enough_credit]     BOOLEAN
)
  proc_label: BEGIN
   -- check if user still has credit to borrow
	CASE
		WHEN remaining_credit >= 1 THEN TRUE
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






CREATE PROCEDURE borrow_via_guest (
    IN [user_id]            INT, 
    IN [remaining_credit]   INT,
    IN [ISBN]               VARCHAR(20),
    IN [borrow_days]        INT,
    OUT [enough_credit]     BOOLEAN,
    OUT [copy_available]    BOOLEAN
)
  proc_label: BEGIN
   -- check if user still has credit to borrow
	CASE
		WHEN remaining_credit >= 1 THEN TRUE
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