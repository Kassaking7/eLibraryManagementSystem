-- Caller: admin
-- Senario: set up an event
-- Input: event_name, start_date_time, end_date_time, capacity, description
--        location_ID, admin_ID
-- Output: if_succeeded

-- Caller: admin
-- Senario: set up an event
-- Input: event_name, start_date_time, end_date_time, capacity, description
--        location_ID, admin_ID
-- Output: if_succeeded

drop procedure event_setup;

DELIMITER //
CREATE PROCEDURE event_setup(
    IN event_name              VARCHAR(100),
    IN start_date_time         VARCHAR(100),
    IN end_date_time           VARCHAR(100),
    IN capacity                INT,
    IN description             VARCHAR(6000),
    IN location_ID             BIGINT,
    IN admin_ID                BIGINT,
    OUT if_succeeded           BOOLEAN
)

proc_label: BEGIN
    -- varchar to datetime
    SET @start_time = (SELECT CONVERT(start_date_time, DATETIME));
    SET @end_time = (SELECT CONVERT(end_date_time, DATETIME));
    
    -- check if the Administrator can host event
    SET if_succeeded = (admin_ID in (SELECT ID FROM Administrator inner join
    in_charged_by on in_charged_by.administrator_ID = Administrator.ID where in_charged_by.location_ID = location_ID
    AND Administrator.can_host_event = TRUE));
    
    -- exit the process if fail
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- check if the start/end time is within the opening time of the location
    SET @after_open = ((SELECT open_time FROM Location WHERE Location.ID = location_ID) <= (SELECT TIME(@start_time)) and (@start_time >= (SELECT NOW())));
    SET @before_close = ((SELECT close_time FROM Location WHERE Location.ID = location_ID) >= (SELECT TIME(@end_time)) and (@start_time >= (SELECT NOW())));
    SET if_succeeded = 
    CASE
        WHEN ((@after_open = TRUE) AND (@before_close = TRUE)) THEN TRUE
        ELSE FALSE
    END;

    -- exit the process if fail
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- check if the start_date_time and end_date_time overlap with other event
    SET @conflict_event = (SELECT COUNT(*) FROM Event
                            WHERE Event.location_ID = location_ID
                            AND  ((@start_time BETWEEN Event.start_date_time AND Event.end_date_time) OR 
								(@end_time BETWEEN Event.start_date_time AND Event.end_date_time))
                                );
    
    SET if_succeeded = 
    CASE
        WHEN (@conflict_event = 0) THEN TRUE
        ELSE FALSE
    END;

	-- exit the process if fail
    IF (if_succeeded = FALSE) THEN
        LEAVE proc_label;
    END IF;

    -- insert a record into Event table
    INSERT INTO Event (name, start_date_time, end_date_time, capacity, current_amount, description, location_ID, admin_ID)
    VALUES(event_name, @start_time, @end_time, capacity, 0, description, location_ID, admin_ID);

END //
