##############################
## test_createGuestAccount
##############################
# Test the function for creating guest account
## Expected these account to appear in both Guest and People Tables.
## In the People table, "is_guest" should be 1 for these inserted rows
## In the Guest table, "is_activated" should be 0 for these rows
## In the Guest table, "credit_level" and "remaining_credit" should be 5, and "late_fee" should be 0.

call create_guest_account('user1', 'zxdchf12345', '12345@gmail.com', @userid_t1);
select @userid_t1 as t1;

call create_guest_account('guest2', '1234512345', '12345@qq.com', @userid_t2);
select @userid_t2 as t2;

call create_guest_account('user4', '341hf12345', '5345@gmail.com', @userid_t3);
select @userid_t3 as t3;

call create_guest_account('user5', 'z341145', '151345@gmail.com', @userid_t4);
select @userid_t4 as t4;

call create_guest_account('user6', 'get41145', '69357345@gmail.com', @userid_t4);
select @userid_t4 as t4;





##############################
## test_password
##############################
# Test the function for checking if user password is correct 
call match_password('101', 'zxdchf12345', @password_match_t1);
select @password_match_t1 as t1; #Expect: 1

call match_password('102', '0123em45mis!@', @password_match_f1);
select @password_match_f1 as f1; #Expect: 0





##############################
## test_activateGuestAccount
##############################
# test the functino for activate Guest Account
## In the Guest table, "is_activated" should be 1 for the users with these ID. No other changes to the current account
call activate_guest_account(101);
call activate_guest_account(102);



##############################
## test_bookSearch
##############################
# test the bookSearch function
## Search by ISBN
call book_search('007-8-28-546023-7', null, null, null, null); # Expected: '007-8-28-546023-7'
call book_search('015-6-42-186006-6', null, null, null, null); # Expected: '015-6-42-186006-6'
## Search by Book Name
call book_search(null, 'D', null, null, null); # Expected: '164-4-02-012480-1', '395-0-36-720557-5', '007-8-28-546023-7', '580-0-52-490012-3'
call book_search(null, 'Active', null, null, null); # Expected: '862-4-25-536823-6'
call book_search(null, 'Activeeeeee', null, null, null); # Expected: no result
call book_search(null, 'Acti', null, null, null); # Expected: '862-4-25-536823-6'
## Search by tag_name
call book_search(null, null, 'Art', null, null); # Expected: '296-9-84-024234-0', '672-1-47-810900-3', '638-8-37-351816-0', '549-7-54-517638-6', '722-4-76-658631-2', '487-0-12-864661-2', '627-8-21-279962-9'

## Search by author_name  
call book_search(null, null, null, 'Henri Brettoner', null); # Expected: '722-4-76-658631-2', '021-8-66-898323-6'
call book_search(null, null, null, 'Henri', null); # Expected: '722-4-76-658631-2', '021-8-66-898323-6'
## Search by publisher_name
call book_search(null, null, null, null, 'Metz, Crist and Zemlak'); # Expected: '073-9-59-831762-7', '580-0-52-490012-3', '638-8-37-351816-0', '730-9-79-414507-8'
## Search by title and publisher_name
call book_search(null, "Design", null, null, 'Metz, Crist and Zemlak'); # Expected: '580-0-52-490012-3'
## Search by title and author_name
call book_search(null, "moral", null, 'Sherri Haller', null); # Expected: '638-8-37-351816-0'





##############################
## test_showDetailedBookInfo
##############################
# Test the function for showeing book info (detailed)
# Will show the book's (title, authors, publisher, publication_year, tags, available_copies, description)
call show_detailed_book_info('638-8-37-351816-0');  # Expect: ('moral foundations of civil society', 'Ferdie Culbard,Nikki Kondrat,Sherri Haller', 'Metz, Crist and Zemlak', '2005', 'Art,Development,History,Paranormal,Thriller', '3')
call show_detailed_book_info('730-9-79-414507-8'); # Expect: ('Autodesk VIZ Fundamentals', NULL, 'Metz, Crist and Zemlak', '1960', 'Contemporary,Fantasy,Thriller', '2')
call show_detailed_book_info('999-9-49-243152-9'); # Expected: no result


##############################
## test_showGeneralBookInfo
##############################
# Test the function for showeing book info (general)
# Will show the book's (title, authors, publisher, publication_year, tags)
call show_general_book_info('638-8-37-351816-0'); # Expect: ('moral foundations of civil society', 'Ferdie Culbard,Nikki Kondrat,Sherri Haller', 'Metz, Crist and Zemlak', '2005', 'Art,Development,History,Paranormal,Thriller')
call show_general_book_info('730-9-79-414507-8');  # Expect: ('Autodesk VIZ Fundamentals', NULL, 'Metz, Crist and Zemlak', '1960', 'Contemporary,Fantasy,Thriller')
call show_general_book_info('999-9-49-243152-9');  # Expect: no result



##############################
## test_borrowAdmin
##############################
# test the borrow function (via Admin)
- Reset Credit Level
UPDATE GUEST
SET remaining_credit = 5
WHERE GUEST.ID = 11;

-- Reset Copy
UPDATE Copy
SET availability = true
WHERE ISBN = 47 OR ISBN = 3 OR ISBN = 21 OR ISBN = 13;

## No Update
# Guest not activated
call borrow_via_admin(103, '007-8-28-546023-7', 1,@enough_credit1);
select @enough_credit1; # Expect 0

## After the update, the guest with ID 101 should have remaining_credit 4
## Book with ISBN '007-8-28-546023-7' should have 1 copy available
call borrow_via_admin(101, '007-8-28-546023-7', 1, @enough_credit2);
select @enough_credit2; # Expect 1

## After the update, the guest with ID 101 should have remaining_credit 3
## Book with ISBN '007-8-28-546023-7' should have 0 copy available
call borrow_via_admin(101, '007-8-28-546023-7', 2, @enough_credit3);
select @enough_credit3; # Expect 1

## After the update, the guest with ID 101 should have remaining_credit 2
## Book with ISBN '015-6-42-186006-6' should have 2 copy available
call borrow_via_admin(101, '015-6-42-186006-6', 1, @enough_credit5);
select @enough_credit5; # Expect 1

## After the update, the guest with ID 101 should have remaining_credit 1
## Book with ISBN '015-6-42-186006-6' should have 1 copy available
call borrow_via_admin(101, '015-6-42-186006-6', 2, @enough_credit6);
select @enough_credit6; # Expect 1

## After the update, the guest with ID 101 should have remaining_credit 0
## Book with ISBN '015-6-42-186006-6' should have 0 copy available
call borrow_via_admin(101, '015-6-42-186006-6', 3, @enough_credit7);
select @enough_credit7; # Expect 1

## No Update
call borrow_via_admin(101, '021-8-66-898323-6', 1, @enough_credit8);
select @enough_credit7, @copy_available8; # Expect 0





##############################
## test_borrowGuest
##############################
# test the borrow function (via Guest)
## No update: not enough credit, copy not available
call borrow_via_guest(101, '007-8-28-546023-7', @enough_credit1, @copy_available1);
select @enough_credit1, @copy_available1; # Expect 0 and 0

## No update: enough credit but no copy available
call borrow_via_guest(102, '007-8-28-546023-7', @enough_credit2, @copy_available2);
select @enough_credit2, @copy_available2; # Expect 1 and 0

## No update: guest not activated
call borrow_via_guest(103, '021-8-66-898323-6', @enough_credit10, @copy_available10);
select @enough_credit10, @copy_available10; # Expect 0 and 1



## After the updete, the guest with ID 102 should have remaining_credit 4
## Book with ISBN '021-8-66-898323-6' should have 2 copy available
call borrow_via_guest(102, '021-8-66-898323-6', @enough_credit3, @copy_available3);
select @enough_credit3, @copy_available3; # Expect 1 and 1

## After the updete, the guest with ID 102 should have remaining_credit 3
## Book with ISBN '021-8-66-898323-6' should have 1 copy available
call borrow_via_guest(102, '021-8-66-898323-6', @enough_credit4, @copy_available4);
select @enough_credit4, @copy_available4; # Expect 1 and 1

## After the updete, the guest with ID 102 should have remaining_credit 2
## Book with ISBN '021-8-66-898323-6' should have 0 copy available
call borrow_via_guest(102, '021-8-66-898323-6', @enough_credit5, @copy_available5);
select @enough_credit5, @copy_available5; # Expect 1 and 1


## No update: No available copy
call borrow_via_guest(102, '021-8-66-898323-6', @enough_credit6, @copy_available6);
select @enough_credit6, @copy_available6; # Expect 1 and 0

## After the updete, the guest with ID 102 should have remaining_credit 1
## Book with ISBN '023-0-81-382736-6' should have 1 copy available
call borrow_via_guest(102, '023-0-81-382736-6', @enough_credit7, @copy_available7);
select @enough_credit7, @copy_available7; # Expect 1 and 1

## After the updete, the guest with ID 102 should have remaining_credit 0
## Book with ISBN '023-0-81-382736-6' should have 0 copy available
call borrow_via_guest(102, '023-0-81-382736-6', @enough_credit8, @copy_available8);
select @enough_credit8, @copy_available8; # Expect 1 and 1

## No update: no enough credit
call borrow_via_guest(102, '030-1-98-970228-3', @enough_credit9, @copy_available9);
select @enough_credit9, @copy_available9; # Expect 0 and 1





##############################
## Preparing State
##############################
call create_guest_account('guest1', 'zxdchf12345', '12w3645@gmail.com', @userid_t1);
call create_guest_account('guest2', '1234512345', '1234545@qq.com', @userid_t2);
call create_guest_account('guest3', '341hf12345', '536245@gmail.com', @userid_t3);
call create_guest_account('guest4', 'z341145', '151y23345@gmail.com', @userid_t4);
call create_guest_account('guest5', 'adfgfa42345', '12wbDS345@gmail.com', @userid_t1);
call create_guest_account('guest6', 'fsgv564345', '12wret3RWG45@qq.com', @userid_t2);
call create_guest_account('guest7', 'r1hf15r5', '53FhrwSDG45@gmail.com', @userid_t3);
call create_guest_account('guest8', 'z341145', '151EwrR345@gmail.com', @userid_t4);
call create_guest_account('guest9', 'zxewF345', '123tr45F345@gmail.com', @userid_t1);
call create_guest_account('guest10', '12GW54345', '123wtGFW45@qq.com', @userid_t2);
call create_guest_account('guest11', '3REVW5', '53REEw3EWG45@gmail.com', @userid_t3);
call create_guest_account('guest12', 'zSDFGS145', '15s134V45@gmail.com', @userid_t4);

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
call event_setup('event01', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Event for kids', 25, 1, @t1);
select @t1; #Expect: 0

-- Ouside of the opening hour
call event_setup('event02', '2023-05-11 5:00:00', '2023-05-11 19:00:00', 5, 'Event for kids', 10, 2, @t3);
select @t3; #Expect: 0

-- Ouside of the closing hour
call event_setup('event03', '2023-05-21 13:00:00', '2023-05-21 20:00:00', 5, 'Event for kids', 10, 2, @t4);
select @t4; #Expect: 0


-- Admin not in charge of the location
call event_setup('event06', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 2, @t7);
select @t7; #Expect: 0

call event_setup('event07', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 19, 8, @t8);
select @t8; #Expect: 0

-- Event time in the past
call event_setup('event08', '2023-02-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 17, 8, @t9);
select @t9; #Expect: 0



# Event creation succeed
# No row should be inserted to the "create" datatable.
-- First event inserted
call event_setup('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 17, 8, @t11);
select @t11; #Expect: 1, ('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 3, 2) inserted to "event"


# Event creation fail
-- Overlap Time
call event_setup('event04', '2023-05-01 13:30:00', '2023-05-01 15:00:00', 5, 'Event1', 17, 8, @t5);
select @t5; #Expect: 0


# Event creation succeed
-- A event right after a event
call event_setup('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 10, 2, @t12);
select @t12; #Expect: 1, ('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 3, 2) inserted to "event"

-- End at the library closing time
call event_setup('event13', '2023-05-02 14:00:00', '2023-05-01 17:00:00', 5, 'Reading party3', 18, 4, @t13);
select @t13; #Expect: 1, ('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 13, 4) inserted to "event"

-- Start at the library start time
call event_setup('event14', '2023-05-11 9:00:00', '2023-05-11 9:30:00', 5, 'Reading party4', 18, 4, @t14);
select @t14; #Expect: 1, ('event14', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 13, 8) inserted to "event"





############################################################
## Event_Registration: Test for procedure register_event
############################################################
# Event Registration successful
# increase the current amount of participant in the event by 1; record in the register table
-- Register a event until the capacity is full
call register_event(101, 1, @t11);
select @t11; #Expect: 1, (101, 1) added to the register table, current_amount 1 for event 1 in table "event"
call register_event(102, 1, @t12);
select @t12; #Expect: 1, (102, 1) added to the register table, current_amount 2 for event 1 in table "event"
call register_event(103, 1, @t13);
select @t13; #Expect: 1, (103, 1) added to the register table, current_amount 3 for event 1 in table "event"
call register_event(104, 1, @t14);
select @t14; #Expect: 1, (104, 1) added to the register table, current_amount 4 for event 1 in table "event"
call register_event(105, 1, @t15);
select @t15; #Expect: 1, (105, 1) added to the register table, current_amount 5 for event 1 in table "event"

-- Another registration for a different event
call register_event(101, 2, @t16);
select @t16; #Expect: 1, (101, 2) added to the register table, current_amount 1 for event 2 in table "event"



# Event Registration not successful
-- Event does not exist
call register_event(101, 59, @t01);
select @t01; #Expect: 0

-- capacity exceed
call register_event(106, 1, @t02);
select @t02; #Expect: 0




############################################################
## Registration_Cancel: Test for procedure cancel_register
############################################################
# Event cencancellation successful
# increase the current amount of participant in the event by 1; record in the register table
-- Register a event until the capacity is full
call cancel_register(101, 1, @t11);
select @t11; #Expect: 1, (101, 1) removed from the register table, event with id 1 has current_amount 4



# Event cencancellation not successful
-- Event does not exist
call cancel_register(101, 59, @t01);
select @t01; #Expect: 0


-- Guest have not registered
call cancel_register(107, 1, @t03);
select @t03; #Expect: 0





############################################################
## Book_Return: Test for procedure book_return
############################################################
# First create some borrowing records
- Expect remaining_credit for guest with ID 103 to decrease by 1 (now is 4), and copy 1 for book with ISBN '030-6-46-961682-1' is now unavailable
call borrow_via_guest(103, '030-6-46-961682-1', @enough_credit1, @copy_available1);
- Expect remaining_credit for guest with ID 103 to decrease by 1 (now is 3), and copy 1 for book with ISBN '030-6-46-961682-1' is now unavailable
call borrow_via_guest(103, '030-6-46-961682-1', @enough_credit1, @copy_available1);

# Test
- Expect remaining_credit for guest with ID 103 to increase by 1, (now is 4)
- Expect copy's availability for book with ISBN '030-6-46-961682-1' and CopyId 1 to be true,
- Expect return-date for this borrow record to be today's date
call book_return(103 , '030-6-46-961682-1' , 1);
