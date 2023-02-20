
CREATE PROCEDURE borrow_via_admin (
    IN [user_id]            INT, 
    IN [remaining_credit]   INT,
    IN [ISBN]               VARCHAR(20),
    IN [copy_ID]            INT,
    IN [borrow_days]        INT,
    OUT [borrow_valid]      BOOLEAN
)
  proc_label: BEGIN
   -- check if user still has credit to borrow
	CASE
		WHEN remaining_credit >= 1 THEN TRUE
        ELSE FALSE
	END AS result INTO borrow_valid;

    -- if not enough credit, then exist the procedure
    IF borrow_valid = FALSE THEN
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
