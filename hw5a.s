.data
.align 4
prompt: .asciz "Enter a word: \n"
nopali: .asciz"Your entry is not a palindrome\n"
yespali: .asciz"Your entry is a palindrome\n"  
cformat: .asciz"%c"
format: .asciz "%s"
printLength: .asciz "The length of your entry is %d\n"
input: .asciz "                "
respond: .asciz "Your word is %s\n"
continue: .asciz "Would you like to try another entry? [y/n]\n"
input2: .asciz " "
.text

	.align 4
	.global main 
	

main:
	save %sp, (-96) & -8, %sp
	
	set prompt, %o0				
	call printf				!"Enter a word"
	mov 0, %l0

	set format, %o0
	set input, %o1
	call scanf
	mov 0, %l2

getLength:
	
	
	add 	%o1, %l2, %o2 
	ldub 	[%o2], 	%l1
	cmp 	%g0, 	%l1				!comparing string to 0 bit 
	bne,a getLength
	inc %l2

	
	set printLength, %o0
	call printf
	mov %l2, %o1

checkingIfOdd:

	btst 0x01, %l2
	bne,a NOPALI
	sethi %hi(nopali), %o0
	cmp %l2, 1 
	bne,a YESPALI
	set yespali, %o0							!st %l2, [%fp+strlength_s]	
	
												! set the continue prompt
settingIndex:
	add %o1, %l2, %o3		!pointer to the end of the string
	sub %o3, 1, %o3			!fixing the fencepost error
	sll %l2, 2, %l2			!number of pointer shifts from each side of string 

isPalindrome:
	
							!add beginning of string with number of shifts
	sub	%o3, %l0, %o3		!sub from end of string with number of shifts
	ldub [%o1], %l1			!grab the front end char
	ldub [%o3], %l3			!grab the back end char
	
	cmp %l1, %l3			! compare them for equality...
	
	bne,a NOPALI
	set nopali, %o0
	
	inc %l0
	cmp %l0, %l2
	bl,a isPalindrome
	add %o1, %l0, %o1
	
	set yespali, %o0
NOPALI:
	or %o0, nopali, %o0
	call printf
	ba CHAR
	sethi %hi(charString), %o0 

YESPALI:
	or %o0, yespali, %o0
	call printf
	ba CHAR
	sethi %hi(charString), %o0	

CHAR:
	or %o0, charString, %o0
	call printf
	set input2, %o1
	set cformat, %o0
	call scanf
	

	mov 0, %l0
	mov 0, %l1
	set input, %o0
	
	add %l0, %o0, %o0
CHECKCHAR:
	cmp %l0, %l2
	be,a PRINTNUM
	sethi %hi(printnum), %o0

	ldub[%o0], %o2
	subcc %o1, %o2, %g0
	be,a INCREMENT
	inc %l1
	ba CHECKCHAR
	inc %l0
INCREMENT:
	ba CHECKCHAR
	inc %l0
PRINTNUM:
	call printf
	or %o0, printnum, %o0
PROMPTFORCONTINUE:
	
	set continue, %o0
	call printf
	set input2, %o1
	

	set cformat, %o0
	call scanf
	nop

	cmp %o1, 'y'
	be,a main
	nop								! would you like to continue?

END: 
	ta 0
	mov 1, %g1