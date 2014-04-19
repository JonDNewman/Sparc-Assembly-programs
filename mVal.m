divert(-1)
define(yMax, %l3)
define(x_r, %l0)
define(y_r, %l1)
define(temp_r, %l2)
define(temp2_r, %l4)

divert(0)

	.global main

main:
	save %sp, -96, %sp
	set -2, x_r


loop:
	cmp x_r, 8
	bg,a end
	mov 1, %g1
	mov x_r, %o0
	call .mul			!x^2 in %o0
	mov x_r, %o1			!x^2 in temp_r %l2
	mov %o0, temp_r			!moving result x^2 to temporary		
	call .mul			!call to multiply x^2 * x
	mov x_r, %o1			!ensuring %o1 still contains x
	mov %o0, temp2_r		!moving result x^3 into temp2 reg
	set 14, %o0			!setting up for 14x^2
	call .mul			!call to multiply 14*x^2
	mov temp_r, %o1			!moving x^2 to multiplicand
	sub temp2_r, %o0, temp_r	!x^3-14x^2 in temp_r
	mov x_r, %o0			!setting up for 56*X
	call .mul			!
	set 56, %o1			!56*x in %o0
	add %o0, temp_r, temp_r		!x^3-14x^2+56x in temp_r
	sub temp_r, 64, y_r		!
	cmp x_r, -2			! if this is the first time through, setting the maxVal to
	be,a setYmax			!  f(-2)
	mov y_r, yMax
	ba test
	cmp y_r, yMax

test:

	bg,a setYmax
	mov y_r, yMax
	cmp x_r, 8
	ble,a loop
	inc x_r
	ba end
	mov 1, %g1

setYmax:

	ba loop
	inc x_r

end:

	ta 0
