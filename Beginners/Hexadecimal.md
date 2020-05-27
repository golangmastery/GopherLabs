
---

# Numeral systems -  hexadecimal



        package main

        import "fmt"

        func main() {
	        //	fmt.Printf("%d - %b - %x \n", 42, 42, 42)
	       //	fmt.Printf("%d - %b - %#x \n", 42, 42, 42)
	      //	fmt.Printf("%d - %b - %#X \n", 42, 42, 42)
	        fmt.Printf("%d \t %b \t %#X \n", 42, 42, 42)
       }
 
 
 output:      
       
       42 	 101010 	 0X2A 

in above program the annotation verb %x formats a number in hexadecimal  Ex:- which represent 0X2A   ( base 16 format)

integer to hexadecimal cheatsheet:


	%x	base 16, with lower-case letters for a-f
        %x	base 16, with upper-case letters for a-f
