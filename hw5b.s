	.data
	.align 4
prompt: .asciz "Enter a word: \n"
nopali: .asciz"Your entry is not a palindrome\n"
yespali: .asciz"Your entry is a palindrome\n"
format: .asciz "%s"
printLength: .asciz "The length of your entry is %d\n"
input: .asciz "                "
respond: .asciz "%s\n"
pcontinue: .asciz "\nWould you like to try another entry? [y/n]\n"
input2:  .asciz"  "
charString: .asciz "Please enter a character: \n"
printnum: .asciz "The character occurs %d times\n"
	.global main 
	.text
	.align 4
main:
	save %sp, (-96) & -8, %sp	
	set prompt, %o0				
	call printf				!"Enter a word"
	mov 0, %l0
	set format, %o0
	set input, %o1
	call scanf
	mov 0, %l2
	mov %o1, %l5
getLength:	
	add 	%o1, %l2, %o2 
	ldub 	[%o2], 	%l1
	cmp 	%g0, 	%l1				!comparing string to 0 bit 
	bne,a getLength
	inc %l2	
	set printLength, %o0
	call printf
	mov %l2, %o1
	set input, %o1												! set the continue prompt
	settingIndex:
		add %o1, %l2, %o3	
		sub %o3, 1, %o3
		ldub [%o3], %o0				
		srl %l2, 1, %l4			!number of pointer shifts from each side of string

CHAR:
	set charString, %o0
	call printf
	nop	
	set format, %o0
	set input2, %o1	
	call scanf
	nop
	set input2, %o1
	set respond, %o0
	call printf	
HERE:nop
	set input, %l5
	set input2, %o1
	ldub [%o1], %l4	
	mov 0, %l0			!how many shifts have been done
	mov 0, %l1			! counter for number of occurrences	
CHECKCHAR:
	cmp %l0, %l2
	be PRINTNUM
	nop	
	ldub[%l5], %l3 
	add %l5, 1,%l5 
	cmp %l3,%l4 
	be,a INCREMENT
	inc %l1
	ba CHECKCHAR
	inc %l0
INCREMENT:
	ba CHECKCHAR
	inc %l0
PRINTNUM:
	set printnum, %o0
	call printf	
	mov %l1, %o1			!number of time char occurs is stored in %l1, moved to %l2
PROMPTFORCONTINUE:
	set pcontinue, %o0
	call printf
	nop	
	set input2, %o1
	set format, %o0
	call scanf
	nop
	ldub [%o1], %l1
 	cmp %l1, 'y'
	be main
	nop					! would you like to continue?
END: 
	mov 1, %g1
	ta 0
	