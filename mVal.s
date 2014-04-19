

	.global main

main:
	save %sp, -96, %sp
	set -2, %l0


loop:
	cmp %l0, 8
	bg,a end
	mov 1, %g1
	mov %l0, %o0
	call .mul			!x^2 in %o0
	mov %l0, %o1			!x^2 in %l2 %l2
	mov %o0, %l2			!moving result x^2 to temporary		
	call .mul			!call to multiply x^2 * x
	mov %l0, %o1			!ensuring %o1 still contains x
	mov %o0, %l4		!moving result x^3 into temp2 reg
	set 14, %o0			!setting up for 14x^2
	call .mul			!call to multiply 14*x^2
	mov %l2, %o1			!moving x^2 to multiplicand
	sub %l4, %o0, %l2	!x^3-14x^2 in %l2
	mov %l0, %o0			!setting up for 56*X
	call .mul			!
	set 56, %o1			!56*x in %o0
	add %o0, %l2, %l2		!x^3-14x^2+56x in %l2
	sub %l2, 64, %l1		!
	cmp %l0, -2			! if this is the first time through, setting the maxVal to
	be,a setYmax			!  f(-2)
	mov %l1, %l3
	ba test
	cmp %l1, %l3

test:

	bg,a setYmax
	mov %l1, %l3
	cmp %l0, 8
	ble,a loop
	inc %l0
	ba end
	mov 1, %g1

setYmax:

	ba loop
	inc %l0

end:

	ta 0
