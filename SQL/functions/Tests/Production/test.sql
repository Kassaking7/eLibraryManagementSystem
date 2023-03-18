##############################
## Preparing State
##############################
# Inser Guest and Activate
call create_guest_account('guest1', 'zxdchf12345', '12345@gmail.com', @userid_t1);
call create_guest_account('guest2', '1234512345', '12345@qq.com', @userid_t2);
call create_guest_account('guest3', '341hf12345', '5345@gmail.com', @userid_t3);
call create_guest_account('guest4', 'z341145', '151345@gmail.com', @userid_t4);
call create_guest_account('guest5', 'adfgfa42345', '12DS345@gmail.com', @userid_t1);
call create_guest_account('guest6', 'fsgv564345', '123RWG45@qq.com', @userid_t2);
call create_guest_account('guest7', 'r1hf15r5', '53FSDG45@gmail.com', @userid_t3);
call create_guest_account('guest8', 'z341145', '151ER345@gmail.com', @userid_t4);
call create_guest_account('guest9', 'zxewF345', '12345F345@gmail.com', @userid_t1);
call create_guest_account('guest10', '12GW54345', '123GFW45@qq.com', @userid_t2);
call create_guest_account('guest11', '3REVW5', '53REEEWG45@gmail.com', @userid_t3);
call create_guest_account('guest12', 'zSDFGS145', '15134V45@gmail.com', @userid_t4);

call activate_guest_account(101);
call activate_guest_account(102);
call activate_guest_account(103);
call activate_guest_account(104);
call activate_guest_account(105);
call activate_guest_account(106);
call activate_guest_account(107);
call activate_guest_account(108);
call activate_guest_account(109);
call activate_guest_account(110);



##############################
## Event_SetUp
##############################
# Event creation failed
# No row should be inserted to the "event" datatable.
-- Admin cannot host event
call event_setup('event01', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Event for kids', 1, 1, @t1);
select @t1; #Expect: 0

-- Ouside of the closing hour
call event_setup('event02', '2023-05-11 13:00:00', '2023-05-11 7:00:00', 5, 'Event for kids', 3, 1, @t3);
select @t3; #Expect: 0
call event_setup('event03', '2023-05-21 13:00:00', '2023-05-21 20:00:00', 5, 'Event for kids', 3, 1, @t4);
select @t4; #Expect: 0

-- Overlap Time
call event_setup('event04', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Event1', 1, 1, @t5);
select @t5; #Expect: 0
call event_setup('event05', '2023-05-01 14:00:00', '2023-05-01 15:00:00', 5, 'Event2', 1, 1, @t6);
select @t6; #Expect: 0


# Event creation succeed
# No row should be inserted to the "create" datatable.
-- First event inserted
call event_setup('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 3, 2, @t2);
select @t2; #Expect: 1, ('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 3, 2) inserted to "event"

-- A event right after a event
call event_setup('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 3, 2, @t6);
select @t6; #Expect: 1, ('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 3, 2) inserted to "event"

-- End at the library closing time
call event_setup('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 4, @t7);
select @t7; #Expect: 1, ('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 4) inserted to "event"

-- Start at the library start time
call event_setup('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 13, 8, @t8);
select @t8; #Expect: 1, ('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 13, 8) inserted to "event"




