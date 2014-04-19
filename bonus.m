divert(-1)
include(macro_defs.m)
.data
.align 4
start: .asciz"Please enter in an array of at most 20 positive integers: "
inputF: .asciz"%d%c"
input:  .word 0
nL:	.byte 0
prLen: .asciz"The length of the array is %d elements\n"
noPali: .asciz"Your entry is not a palindrome\n"
yesPali: .asciz"Your entry is a palindrome\n"
pcontinue: .asciz "\nWould you like to try again? [y/n]\n"

.text
.align 4
.global main

local_var
var(arr_s, 4, 21*4)
define(i_r, l0)
divert(0)
begin_
clr %i_r
clr %l2
add %l2, arr_s, %l5
INIT:
set start, %o0		! LOOP:prompt user to enter up to 20 numbers.
call printf

sll %i_r, 2, %l3

set inputF, %o0		! Store the numbers into the array in stack memory
set input, %o1
set nL, %o2
call scanf
add %fp, %l3, %l3
ld [%o1], %l1
st %l1, [%l5+%l3]
cmp %l1, 0
bne,a INIT
inc %i_r
call getLength			!call a function to print the length of the given array
add %fp, arr_s, %o0		!passing to getLength a pointer to the array
			
set prLen, %o0
call printf
mov %g2, %o1
set input, %o1
set noPali, %o2
add %fp, arr_s, %g3
HERE:
call isPalindrome		! call a function to determine if given array contains palindrome

nop
call printf
nop

		
		!    pass a pointer to the array in memory.



end_




isPalindrome:	


mov %o2, %o4
clr %o5
sll %g2, 2, %g4
add %g3, %g4, %g4
sub %g4, 4, %o2
srl %g2, 1, %g2
LOOP:
	ld [%g3], %o1			!grab the front  char
	ld [%o2], %o3			!grab the back  char
	cmp %o1, %o3			! compare them for equality...
	bne,a DONE
	mov %o4, %o0			!delay slot
	inc %o5
	sub	%o3, 4, %o3
	cmp %o5, %g2
	bl,a LOOP
	add %o1, 4, %o1
	set yesPali, %o0
DONE:
retl
nop


getLength:



define(arr_p, o0)
mov -1, %g2
COMPARE:
inc %g2
ld [%arr_p], %o1
cmp %o1, 0
bne,a COMPARE
add %arr_p, 4, %arr_p
 

retl 
nop

