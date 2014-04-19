




.global main

main:

mov 21, %l0		! question 1, question 2
sll %l0, 8, %l3	! q3
srl %l0, 8, %l4	! q3
xor %l3, %l4, %l5	! q3: answer in L5
			! 
btst 0x03, %l0		! q4: testing the 0 and 1 position of the number
be,a q5			! q4: if first two bits  == 0, branch to done
mov 1, %l2		! q4: if prev is true, set temp to value
mov 0, %l2		! q4: if prev is false, set temp to value
		
q5:
	
	
not %l0, %l1		! complement %l0, store into %l1 
sll %l1, 16, %l1	! remove leading 1's
srl %l1, 16, %l1	! reposition to original placement
mov 1,%g1		

ta 0
