
.global main


main:
	save %sp, -64, %sp

	set -2, %l0

	
	
loop:	
		
	mov %l0, %o0
	call .mul
	mov %l0, %o1		! %l0^2 in %o0
	mov %o0, %l2		! %l0^2 in %l2 register %l2
	call .mul
	mov %l0, %o1		! %l0^3 in %o0
	mov %o0, %l4		! %l0^3 in %l4
	set 14, %o0
	call .mul
	mov %l2, %o1		! 14%l0^2 in %o0
	sub %l4, %o0, %l2	! %l0^3-14%l0^2 in %l2
	mov %l0, %o0
	call .mul
	set 56, %o1		! 56%l0 in %o0
	add %o0, %l2, %l2	! %l0^3-14%l0^2+56%l0 in %l2
	sub %l2, 64, %l1		! %l0^3-14%l0^2+56%l0-64 in %l1
	cmp %l0, -2		! checks to see if in first %l0 value
	be,a setYmax		! if %l0==-2, branch to setYmax and set %l3 to f(-2)
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
	set 1, %g1
		
setYmax:
	
	ba loop
	inc %l0

end:   

	ta 0
	



	
	
	
	
