############### Test
-- Reset Credit Level
UPDATE GUEST
SET remaining_credit = 5
WHERE GUEST.ID = 11;

-- Reset Copy
UPDATE Copy
SET availability = true
WHERE ISBN = 47 OR ISBN = 3 OR ISBN = 21 OR ISBN = 13;


-- Test Cases
## No Update
call borrow_via_admin(10, 47, 1, @enough_credit1);
select @enough_credit1; # Expect 0

## After the update, the guest with ID 11 should have remaining_credit 4
## Book with ISBN 47 should have 2 copy available
call borrow_via_admin(11, 47, 1, @enough_credit2);
select @enough_credit2; # Expect 1

## After the update, the guest with ID 11 should have remaining_credit 3
## Book with ISBN 47 should have 1 copy available
call borrow_via_admin(11, 47, 2, @enough_credit3);
select @enough_credit3; # Expect 1

## After the update, the guest with ID 11 should have remaining_credit 2
## Book with ISBN 47 should have 0 copy available
call borrow_via_admin(11, 47, 3, @enough_credit4);
select @enough_credit4; # Expect 1


## After the update, the guest with ID 11 should have remaining_credit 1
## Book with ISBN 3 should have 0 copy available
call borrow_via_admin(11, 3, 1, @enough_credit5);
select @enough_credit5; # Expect 1


## After the update, the guest with ID 11 should have remaining_credit 0
## Book with ISBN 21 should have 0 copy available
call borrow_via_admin(11, 21, 1, @enough_credit6);
select @enough_credit6; # Expect 1

## No Update
call borrow_via_admin(11, 13, @enough_credit7);
select @enough_credit7, @copy_available7; # Expect 0