




.global main
main:
save %sp, -96, %sp
mov %l0, %o0
mov %l0, %o1
call .mul
call .mul
mov %o0, %l2
call .mul
mov 10, %o1
call .mul
sub %o0, 30, %l1
mov %l2, %o0
mov 2, %o1
call .mul
mov %o0, %l3
mov %l0, %o0
call .mul
mov %o0, %l4
add %l3, %l4, %l3
add %l3, 3, %l3
mov %l3, %o1
mov %l1, %o0
call .div
mov 1, %g1
ta 0
