-- Caller: admin or guests
-- Senario: register an event
-- Input: guest_ID, event_id
-- Output: if_registerd

DROP PROCEDURE IF EXISTS register_event;

DELIMITER //
CREATE PROCEDURE register_event(
    IN guest_ID            BIGINT, 
    IN event_ID            BIGINT,
    OUT if_registerd       BOOLEAN
)

proc_label: BEGIN
    -- to check if the event exist
    SET if_registerd = (event_ID in (SELECT ID FROM Event));

    -- if cannot register, then exist the procedure
    IF (if_registerd = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- check if there enough capacity to register or the event ended
    SET if_registerd = 
    CASE
        WHEN (SELECT end_date_time FROM Event WHERE Event.ID = event_ID) < (SELECT NOW()) THEN FALSE
        WHEN (SELECT current_amount FROM Event WHERE Event.ID = event_ID) < (SELECT capacity FROM Event WHERE Event.ID = event_ID) THEN TRUE
        ELSE FALSE
    END;

    -- if cannot register, then exist the procedure
    IF (if_registerd = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- increase the current amount of participant in the event
    UPDATE Event
    SET Event.current_amount = Event.current_amount + 1
    WHERE Event.ID = event_ID;

    -- insert a record into Registration table
    INSERT INTO Registration
    VALUES(guest_ID, event_ID);

END //
