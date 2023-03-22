-- Caller: admin or guests
-- Senario: cancel the registration of an event
-- Input: guest_ID, event_id
-- Output: if_succeeded

DROP PROCEDURE IF EXISTS cancel_register;

DELIMITER //
CREATE PROCEDURE cancel_register(
    IN guest_ID            BIGINT, 
    IN event_ID            BIGINT,
    OUT if_succeeded       BOOLEAN
)

proc_label: BEGIN
    -- to check if the event exist
    SET if_succeeded = (event_ID in (SELECT ID FROM Event));

    -- if cannot register, then exist the procedure
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;
    
    -- to check if the registration exists
    SET if_succeeded = (guest_ID in (select registration.guest_ID from registration where event_ID = registration.event_ID ));
    
    -- if cannot register, then exist the procedure
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- if cannot register, then exist the procedure
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- check if event ended
    SET if_succeeded = 
    CASE
        WHEN (SELECT end_date_time FROM Event WHERE Event.ID = event_ID) < (SELECT NOW()) THEN FALSE
        ELSE TRUE
    END;

    -- if cannot cancel, then exist the procedure
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- decrease the current amount of participant in the event
    UPDATE Event
    SET Event.current_amount = Event.current_amount - 1
    WHERE Event.ID = event_ID;

    -- remove the record from Registration table
    DELETE FROM Registration
    WHERE (Registration.guest_ID, Registration.event_ID) = (guest_ID, event_ID);

END //
