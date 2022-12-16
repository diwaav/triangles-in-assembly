#######################################################################################
# Created by:  Ashwini Vittala, Diwa
#              dashwini
#              14 May 2021
# Assignment:  Lab 3: ASCII-risks (Asterisks)
#              CSE 12/L
#              UC Santa Cruz, Spring 2021
# Description: This program prints a triangle made up of numbers and aesterics
#              of a height that is specified by the user.
########################################################################################
#
# Pseudocode:
# Ask user for height of triangle (number should be > 0)
# If number is greater than 0:
# 	Go to label "Good Value" and proceed normally
# Bad Number (label BadValue): invalid input number 
# 	Give user "Invalid Entry" message
# 	Start over from beginning (Start), ask prompt again
# Good Number (label GoodValue): number is > 0
# 	Set register values accordingly:
# 		$t0 = original user input value
# 		$t1 = height count down (counts down from the user input)
# 		$t2 = count for total number of first tabs per row
# 		$t3 = countdown for each of the first tabs in a given row
# 		$t4 = the numbers in the triangle
# 		$t5 = counts the number of tabs and stars "\t*" pattern needed for each row
# 	Move row by row (label EachRow):
# 		Print first tabs (label FirstTabs)
# 			There are "height - 1" first tabs
# 		Print first number (label FirstNumber)
# 			If user input is 1, print 1 and end program
# 			If on first line:
# 				Change register values to indicate you're moving to a new line
# 				Start EachRow again
# 			Else if not on the first line, continue
# 		Print Tab and Star pattern (label TabsAndStars)
# 			Each tab and star "\t*" is considered 1 loop, 
# 			and loop "FirstNumber - 1" times
# 		Print last tab
# 		Print last number (label LastNumber)
# 			Last number is "FirstNumber + 1"
#		Start a new line/row (label NewLine)
# 		If not on last row (meaning height != 0)
# 			Set up everything for next row (height-1, number+1, etc.)
# 			Loop back to EachRow
# 		If just finished last row:
# 			Finish program with exit syscall (label Exit)
#
########################################################################################

.data
	Prompt: .asciiz "Enter the height of the pattern (must be grater then 0):	"
	InvalidEntry: .asciiz "Invalid Entry!\n"
	
.text
	Start:
		li $v0, 4                                  # ask user for input using Prompt from memory
		la $a0, Prompt
		syscall
		
		li $v0, 5                                  # read the value that the user input and put it into register t0
		syscall
		move $t0, $v0   
		
		bgtz $t0, GoodValue                        # if the user input value is > 0, its good! Continue on.
	
	BadValue:                                          # value didn't pass the check for > 0 so it doesn't skip this section
		li $v0, 4                                  # inform users that their input is invalid
		la $a0, InvalidEntry
		syscall
		
		j Start                                    # ask the user to put in input again, so start over
	
	GoodValue:                                         # yes, value is greater than zero and skipped that "BadValue" section
		# set the values!
		# $t0 = original user input value
		# $t1 = height count down (counts down from the user input)
		# $t2 = count for total number of first tabs per row
		# $t3 = countdown for each of the first tabs in a given row
		# $t4 = the numbers in the triangle
		# $t5 = counts the number of tabs and stars "\t*" pattern needed for each row
		move $t1, $t0                              # row number, or height count down
		move $t2, $t0                              # total number of first tabs per row/line
		move $t3, $t0                              # count down for the number of first tabs
		addi $t4, $zero,       1                   # numbers in triangle
		
		EachRow:
			subi $t2, $t2, 1                    # start countdown for number of first tabs
			move $t3, $t2 
			beqz $t2, FirstNumber               # if its zero, must be last row... go straight down to FirstNumber
			
			FirstTabs:                          # all the first tabs in the triangle
				li $v0, 11                  # print one of the first tabs
				li $a0, '\t' 
				syscall
				
				subi $t3, $t3, 1            # count down
				bgtz $t3, FirstTabs         # if the count down has not reached zero, then keep going
			
			FirstNumber:                        # the number right after the first tabs
				li $v0, 1                   # places the first number right after the FirstTabs
				move $a0, $t4
				syscall
				
				beq $t0, 1, NewLine         # If user input is 1, just print 1 and end it
		
				beq $t0, $t1, linezero      # is this the first line of the triangle?
				
				subi $t5, $t4, 1            # sets up the number of tabs+stars pattern needed
				j TabsAndStars              # this must not be the top row
				
				linezero:                   # this must be the top row
					addi $t4, $t4, 1    # since theres only 1 number in the first row, lets end this loop for the row here
					li $v0, 11          # meaning, theres no tabs and stars pattern and no second number, don't want to move on 
					li $a0, '\n'
					syscall
					
					subi $t1, $t1, 1    # count down the height so you know you are going to next line
					j EachRow           # start the next row
			
			TabsAndStars:                       # patterns of tabs and stars
				li $v0, 11                  # print the tab
				li $a0, '\t'
				syscall
				
				li $v0, 11                  # print the star right after the tab
				li $a0, '*'
				syscall
				
				subi $t5, $t5, 1
				bgtz $t5, TabsAndStars      # if count down still going, loop again
				
				li $v0, 11                  # else, last tab and move on
				li $a0, '\t'
				syscall
				
			LastNumber:                         # last number in row should be FirstNumber + 1
				addi $t4, $t4, 1
				li $v0, 1
				move $a0, $t4
				syscall
				
			NewLine:                            # Set up the values needed for our next row
				li $v0, 11
				li $a0, '\n'                # make a new line
				syscall

		NextLineSetUp:
			addi $t4, $t4, 1                    # lets add 1 to the number
			subi $t1, $t1, 1                    # just finished this row, so height - 1
			bgtz $t1, EachRow                   # count down for each row still happening? loop back for next row
			
	Exit:                                               # $t0 must be 0, so we finished our last row! End program
		li $v0, 10
		syscall
		
