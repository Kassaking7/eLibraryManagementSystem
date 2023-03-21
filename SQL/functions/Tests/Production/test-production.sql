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



############################################################
## Event_SetUp: Test for procedure event_setup
############################################################
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

-- Admin not in charge of the location
call event_setup('event06', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 21, 4, @t7);
select @t7; #Expect: 0, ('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 4) inserted to "event"
call event_setup('event07', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 12, 8, @t8);
select @t8; #Expect: 0, ('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 13, 8) inserted to "event"

-- Event time in the past
call event_setup('event08', '2023-02-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 18, 4, @t9);
select @t9; #Expect: 0, ('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 4) inserted to "event"
call event_setup('event09', '2021-03-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 17, 8, @t10);
select @t10; #Expect: 0, ('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 13, 8) inserted to "event"



# Event creation succeed
# No row should be inserted to the "create" datatable.
-- First event inserted
call event_setup('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 10, 2, @t11);
select @t11; #Expect: 1, ('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 3, 2) inserted to "event"

-- A event right after a event
call event_setup('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 10, 2, @t12);
select @t12; #Expect: 1, ('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 3, 2) inserted to "event"

-- End at the library closing time
call event_setup('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 18, 4, @t13);
select @t13; #Expect: 1, ('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 4) inserted to "event"

-- Start at the library start time
call event_setup('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 17, 8, @t14);
select @t14; #Expect: 1, ('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 13, 8) inserted to "event"





############################################################
## Event_Registration: Test for procedure register_event
############################################################
# Event Registration successful
# increase the current amount of participant in the event by 1; record in the register table
-- Register a event until the capacity is full
call register_event(101, 33, @t11);
select @t11; #Expect: 1, (101, 33) added to the register table, current_amount 1 for event 33 in table "event"
call register_event(102, 33, @t12);
select @t12; #Expect: 1, (102, 33) added to the register table, current_amount 2 for event 33 in table "event"
call register_event(103, 33, @t13);
select @t13; #Expect: 1, (103, 33) added to the register table, current_amount 3 for event 33 in table "event"
call register_event(104, 33, @t14);
select @t14; #Expect: 1, (104, 33) added to the register table, current_amount 4 for event 33 in table "event"
call register_event(105, 33, @t15);
select @t15; #Expect: 1, (105, 33) added to the register table, current_amount 5 for event 33 in table "event"

-- Another registration for a different event
call register_event(101, 34, @t16);
select @t16; #Expect: 1, (101, 34) added to the register table, current_amount 1 for event 34 in table "event"



# Event Registration not successful
-- Event does not exist
call register_event(101, 59, @t01);
select @t01; #Expect: 0

-- capacity exceed
call register_event(106, 33, @t02);
select @t02; #Expect: 0




############################################################
## Registration_Cancel: Test for procedure cancel_register
############################################################
# Event Registration successful
# increase the current amount of participant in the event by 1; record in the register table
-- Register a event until the capacity is full
call cancel_register(102, 33, @t11);
select @t11; #Expect: 1, (102, 33) removed from the register table, event with id 33 has current_amount 4



# Event Registration not successful
-- Event does not exist
call register_event(101, 59, @t01);
select @t01; #Expect: 0

-- Event ended
# First add a event at now
call event_setup('event15', '2023-03-19 10:00:00', '2023-03-18 11:00:00', 5, 'Reading party5', 17, 8, @t14);
select @t14;
# Test
call cancel_register(101, 33, @t02);
select @t02; #Expect: 0

-- Guest have not registered
call cancel_register(106, 34, @t03);
select @t03; #Expect: 0





############################################################
## Book_Return: Test for procedure book_return
############################################################
# First create some borrowing records
call borrow_via_guest(101, '000-0-00-179354-2', @enough_credit1, @copy_available1);
call borrow_via_guest(101, '000-0-12-759187-4', @enough_credit1, @copy_available1);
call borrow_via_guest(101, '000-0-12-759187-4', @enough_credit1, @copy_available1);
call borrow_via_guest(101, '000-0-14-820806-0', @enough_credit1, @copy_available1);
call borrow_via_guest(101, '000-0-36-213242-6', @enough_credit1, @copy_available1);
call borrow_via_guest(102, '000-0-67-718592-1', @enough_credit1, @copy_available1);
call borrow_via_guest(102, '000-0-79-115678-5', @enough_credit1, @copy_available1);
call borrow_via_guest(103, '000-0-00-179354-2', @enough_credit1, @copy_available1);

# Test
- Expect remaining_credit for guest with ID 101 to increase by 1, 
- Expect copy's availability for book with ISBN '000-0-00-179354-2' and CopyId 1 to be true,
- Expect return-date for this borrow record to be today's date
call book_return(101 , '000-0-00-179354-2' , 1)
