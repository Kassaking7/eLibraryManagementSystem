##############################
## test_createGuestAccount
##############################
# Test the function for creating guest account
## Expected these account to appear in both Guest and People Tables.
## In the People table, "is_guest" should be 1 for these inserted rows
## In the Guest table, "is_activated" should be 0 for these rows
## In the Guest table, "credit_level" and "remaining_credit" should be 5, and "late_fee" should be 0.

call create_guest_account('Bob C', 'zxdchf12345', '123avds45@kklib.com', @userid_t1);
select @userid_t1 as t1;

call create_guest_account('Simon Zeng', '1234512345', '12gds345@kklib.com', @userid_t2);
select @userid_t2 as t2;

call create_guest_account('Alice Tian', '341hf12345', '534sadfc5@kklib.com', @userid_t3);
select @userid_t3 as t3;

call create_guest_account('Josh Dan', 'z341145', '151adsc345@kklib.com', @userid_t4);
select @userid_t4 as t4;

call create_guest_account('Kyle Smith', 'get41145', '69357345@kklib.com', @userid_t4);
select @userid_t4 as t4;





##############################
## test_password
##############################
# Test the function for checking if user password is correct 
call match_password('113', 'zxdchf12345', @password_match_t1);
select @password_match_t1 as t1; #Expect: 1

call match_password('114', '123451fs45', @password_match_f1);
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
call book_search('000-0-00-179354-2', null, null, null, null); # Expected: '000-0-00-179354-2'
call book_search('000-0-55-412297-2', null, null, null, null); # Expected: '015-6-42-186006-6'

## Search by Book Name
call book_search(null, 'Henry Ford', null, null, null); # Expected: '364-4-47-491195-8', '000-1-22-433498-3', '322-3-68-433249-4'
# Verify correctness: select * from book where isbn in ('364-4-47-491195-8', '000-1-22-433498-3', '322-3-68-433249-4');
# Verify correctness:  select ISBN from book where title LIKE 'Henry Ford%';
call book_search(null, 'Activeeeeee', null, null, null); # Expected: no result
call book_search(null, 'The land of Gray Wolf', null, null, null); # Expected: '000-0-55-412297-2'
# Verify correctness: select * from book where isbn in ('000-0-55-412297-2');
# Verify correctness:  select ISBN from book where title LIKE 'The land of Gray Wolf%';


## Search by tag_name
call book_search(null, null, 'Paranormal', null, null); 
# Expected: (first 5 books, since there are too many results) '011-5-76-749218-6', '038-6-59-510503-1', '047-9-04-030443-0', '060-7-80-404588-5', '075-9-25-433882-2'

# Verify correctness: (Expect 'Paranormal' to be one of the tags, so the expected count should be 1)
select count(*) from (select tag_name from has_tag where isbn = '011-5-76-749218-6') as f where tag_name = 'Paranormal'; # Expected: 1
select count(*) from (select tag_name from has_tag where isbn = '038-6-59-510503-1') as f where tag_name = 'Paranormal'; # Expected: 1
select count(*) from (select tag_name from has_tag where isbn = '047-9-04-030443-0') as f where tag_name = 'Paranormal'; # Expected: 1
select count(*) from (select tag_name from has_tag where isbn = '060-7-80-404588-5') as f where tag_name = 'Paranormal'; # Expected: 1
select count(*) from (select tag_name from has_tag where isbn = '075-9-25-433882-2') as f where tag_name = 'Paranormal'; # Expected: 1



## Search by author_name  

## Chose which author to test (don't want too many outputs)
# select author_id from written_by group by author_id order by count(author_id) asc;
# select name from author where id = 9001;
call book_search(null, null, null, 'Cleavland O Sullivan', null); # Expected: '162-4-18-153828-8', '271-2-39-653404-7'
# Verify correctness: (Expect author with id 9001 to be one of the authors, so the expected count should be 1)
select count(*) from (select author_id from written_by where isbn =  '271-2-39-653404-7') as f where author_id = 9001; # Expected: 1
select count(*) from (select author_id from written_by where isbn = '162-4-18-153828-8') as f where author_id = 9001; # Expected: 1
                               
call book_search(null, null, null, 'Cleavland O', null); # Expected: ('162-4-18-153828-8', '271-2-39-653404-7') (should have the same result as the one above)
                               
## Search by publisher_name
call book_search(null, null, null, null, 'Hartmann LLC'); 
# Expected:(first 5 output since there is too much) '016-8-48-669038-8', '017-0-32-157316-2', '017-5-39-435549-0', '019-6-79-800714-8', '024-7-09-510140-8'
# Verify correctness: (Expect publisher with id 85 to be one of the publishers, so the expected count should be 1)
select count(*) from (select publisher_id from book where isbn =  '016-8-48-669038-8') as f where publisher_id = 85; # Expected: 1
select count(*) from (select publisher_id from book where isbn = '017-0-32-157316-2') as f where publisher_id = 85; # Expected: 1
select count(*) from (select publisher_id from book where isbn = '017-5-39-435549-0') as f where publisher_id = 85; # Expected: 1
select count(*) from (select publisher_id from book where isbn = '019-6-79-800714-8') as f where publisher_id = 85; # Expected: 1
select count(*) from (select publisher_id from book where isbn = '024-7-09-510140-8') as f where publisher_id = 85; # Expected: 1
                               
## Search by title and publisher_name
call book_search(null, "The land of Gray Wolf", null, null, 'Donnelly, Mosciski and Bechtelar'); # Expected: '000-0-55-412297-2'
## Search by title and author_name
call book_search(null, "Advertise for Treasure", null, "Jasmine O'Shevlin", null); # Expected: '084-4-61-239526-8'






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
select @t7; #Expect: 0
call event_setup('event07', '2023-05-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 12, 8, @t8);
select @t8; #Expect: 0

-- Event time in the past
call event_setup('event08', '2023-02-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 18, 4, @t9);
select @t9; #Expect: 0
call event_setup('event09', '2021-03-11 9:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 17, 8, @t10);
select @t10; #Expect: 0



# Event creation succeed
# No row should be inserted to the "create" datatable.
-- First event inserted
call event_setup('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 'Reading party1', 10, 2, @t11);
select @t11; #Expect: 1, ('event11', '2023-05-01 13:00:00', '2023-05-01 14:00:00', 5, 0, 'Reading party1', 10, 2) inserted to "event"

-- A event right after a event
call event_setup('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 'Reading party2', 10, 2, @t12);
select @t12; #Expect: 1, ('event12', '2023-05-01 14:00:01', '2023-05-01 15:00:00', 5, 0, 'Reading party2', 10, 2) inserted to "event"

-- End at the library closing time
call event_setup('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 'Reading party3', 18, 4, @t13);
select @t13; #Expect: 1, ('event13', '2023-05-01 14:00:00', '2023-05-01 17:30:00', 5, 0, 'Reading party3', 18, 4) inserted to "event"

-- Start at the library start time
call event_setup('event14', '2023-05-11 10:00:00', '2023-05-11 12:00:00', 5, 'Reading party4', 17, 8, @t14);
select @t14; #Expect: 1, ('event14', '2023-05-11 10:00:00', '2023-05-11 12:00:00', 5, 0, 'Reading party4', 17, 8) inserted to "event"





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
