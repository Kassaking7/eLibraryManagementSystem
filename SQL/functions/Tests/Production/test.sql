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
## test_activateGuestAccount
##############################



