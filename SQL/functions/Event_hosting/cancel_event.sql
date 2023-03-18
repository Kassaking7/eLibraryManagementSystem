-- Caller: admin
-- Senario: cancel an event
-- Input: event_id
-- Output: if_succeeded

DELIMITER //
CREATE PROCEDURE cancel_event(
    INT event_id             BIGINT NOT NULL,
    OUT if_succeeded         BOOLEAN
)

proc_label: BEGIN

    --check if cancel before happen
    SET if_succeeded = ((SELECT NOW()) < (SELECT start_date_time FROM Event where ID = event_id));

    -- if cannot cancel, then exist the procedure
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- update table
    DELETE FROM Registration
    WHERE Registration.event_ID = event_id;

    DELETE FROM Event
    WHERE Event.ID = event_id;

END //
DELIMITER;
