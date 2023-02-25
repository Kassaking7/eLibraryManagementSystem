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