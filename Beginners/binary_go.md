
# Numeral systems -  binary


    package main

    import "fmt"

    func main() {
	 fmt.Printf("%d - %b \n", 42, 42)
    }

Output:
     
     42 - 101010 

    Program exited.
    
  
Try it On Golang Play Ground  - (https://play.golang.org/p/8oA-JOz0flp) <br> 
in above program the annotation verb %b formats a number in binary  Ex:- which represent 101010 ( base 2 format)
and  the annotation verb %d formats a number in Base 10   Ex:which represent 42 ( base 10 format)

Integer cheatsheet for fmt 

      %b	base 2
      %c	the character represented by the corresponding Unicode code point
      %d	base 10
      %o	base 8
      %q	a single-quoted character literal safely escaped with Go syntax.
      %x	base 16, with lower-case letters for a-f
      %X	base 16, with upper-case letters for A-F
      %U	Unicode format: U+1234; same as "U+%04
    


     
     
