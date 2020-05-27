


##  Numeral Systems


---
## print decimal,binary,hexadecimal number from 10 to 15 using loop 
4.Numeral systems -  using loop

     
     
          package main

          import "fmt"

          func main() {
        	for i := 1; i < 16; i++ {
		      fmt.Printf("%d \t %b \t %x \n", i, i, i)
	        }
          }
 
 output:     
 ```
                0 	 0 	 0 
                1 	 1 	 1 
                2 	 10 	 2 
                3 	 11 	 3 
                4 	 100 	 4 
                5 	 101 	 5 
                6 	 110 	 6 
                7 	 111 	 7 
                8 	 1000 	 8 
                9 	 1001 	 9 
               10 	 1010 	 a 
               11 	 1011 	 b 
               12 	 1100 	 c 
               13 	 1101 	 d 
               14 	 1110 	 e 
               15 	 1111 	 f
	       
```
               
if your new to loop in GO so lets see some detailing of for loop in GO:

            	for i := 1; i < 16; i++ {
              
in above syntax of for its similar to other programming langaugae    

Go has only one looping construct, the for loop.

The basic for loop has three components separated by semicolons:

-the init statement: executed before the first iteration  <br>
-the condition expression: evaluated before every iteration <br>
-the post statement: executed at the end of every iteration. <br>
The init statement will often be a short variable declaration, 
and the variables declared there are visible only in the scope of the for statement.

The loop will stop iterating once the boolean condition evaluates to false.

Note: Unlike other languages like C, Java, or JavaScript there are no parentheses surrounding 
the three components of the for statement and the braces { } are always required.
              

as we seen decimal,binary and hexadecimal programs in Go , in this above program using loop you can print n number that convert 
number to any numeral system ( refer integer cheatsheet fmt) to convert number into different fmt format.quick suing simple Go 
program.


