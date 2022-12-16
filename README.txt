Diwa Ashwini Vittala
dashwini
CSE 12 Spring 2021
Lab 3: ASCII-risks (Asterisks)

DESCRIPTION
In this lab, the user inputs an integer (whole) number that is larger than 0, 
and the program will output a triangle of that height, with numbers on the outside 
and aestericks on the inside. 
I learned a lot about MIPS and using MARS in this lab. Making this program required 
knowledge about using syscall, how to move data to/from memory and registers, flow charts, 
as well as knowledge about control flow. For me, the toughest part of the lab was control flow
and organization, so I decided to draw out a flow chart by hand and also write out all the 
patterns I see in the triangle. Adding lots of meaningful comments and labels 
throughout my lab was also a large part of my organization and it helped me
with debugging. Although it is a tedious task, whenever I had troubles with debugging, I 
decided to go through the entire program step by step by hand, writing down the values
of each register and changes along the way. The reason why this was so helpful was because
when I did it by hand, I can see where I lacked a jump or my organization messed up 
in the eyes of the program. The videos about MIPS/MARS instructions, the 
textbook, and the tutorial by Hilal were extremely helpful in understanding the concept.
Also, running the program step by step (using the playbutton with a number next to it) helped
with checking the register values (displayed to the right) throughout the program.

FILES
All files in directory CSE_12/dashwini/Lab3 (except this one)
Lab3 - This file must be opened using MARS. It contains the instructions for a 
       program that builds a triangle of a specific height, given by user input. To open the file,
       go to MARS > file > open >  Look In CSE_12 > navigate to the Lab3 folder > Lab3.asm.
       The first part of the file is just my name, and information about the assignment/class.
       The next part is a detailed pseudocode that describes how the program is organized as well
       as what each register is trying to do. There are two sections in the actual instruction 
       that follows: .data, which contains the prompt and error message in memory, and then 
       the .text section that is seperated by labels and goes through instructing the program on 
       what to store/load where, and what to print in which order, etc.

INSTRUCTIONS
To start, open the lab from MARS > open file > navigate to lab
Click run > assemble > play button to run the program.
Put in a number that is greater than zero for the height of your triangle.
If your number is smaller than or equal to 0, then you will get an error message "Invalid Entry!"
If your number is greater than 0, the program will print a triangle.
The triangle will have a height as big as the uner input, 
and the last number at the end of the triangle will be (num * 2) - 1 where num is the user input.
For example: If your input is 5, your triangle is 
				1
			2	*	3
		4	*	*	*	5
	6	*	*	*	*	*	7
8	*	*	*	*	*	*	*	9
Where your triangle's height is 5, and (5*2)-1 = (10)-1 = 9 as the last number.