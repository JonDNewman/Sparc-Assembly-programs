


.global main

main:
	mov 0, %l1
	mov 2000, %l0
	mov %l0, %o0  	! initialize 2000 for xmod400
	call .rem   	! call to xmod400
	mov 400, %o1	! initializing 400 for xmod400
	cmp %o0,0
	be,a done		! if xmod400 !=0, branch to LOOPA
	mov 1, %l1	! if multiple of 400, save as Leap Year	
	mov %l0, %o0
	call	.rem
	mov 100, %o1	! initializing 100 to xmod100
	cmp %o0,0
	be, done	! if 2000 is not multiple of 100, continue to LOOPB
	nop
	mov %l0,%o0
	call .rem
	mov 4, %o1
	cmp %o0, 0
	be,a done
	mov 1, %l1



done:
	mov 1, %g1
	ta 0
