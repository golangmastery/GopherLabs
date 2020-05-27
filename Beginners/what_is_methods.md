
## What is Methods?

A method is a function with a receiver. A method declaration binds an identifier, 
the method name, to a method, and associates the method with the receiver's base type.

```
func (t Type) methodName(parameter list) {  
}
```

The above snippet creates a method named `methodName` which has `receiver` type Type.

Let's write a simple program which creates a method on a struct type and calls it.

```
package main

import (
	"fmt"
)

type student struct {
	name     string
	collage_name   string
	course  string
}

/*
 displayname() method has student as the receiver type
*/
func (s student) displayname() {
	fmt.Printf(" student details of %s \n is %s \n %s", s.name, s.collage_name, s.course)
}

func main() {
	stud1 := student{
		name:     "Sangam biradar",
		collage_name:  "alliance University Bengalore" ,
		course: "btech",
	}
	stud1.displayname() //Calling displayname() method of student type
}
```

try on -[Go PlayGround](https://play.golang.org/p/myRvCjqX_td)


## Receivers

There are two types of receivers:
- value :
you don’t need to change the value making the method call
- pointer :
you need to change the value making the method call

lets me give you simple example on:(value)
```
package main

import (
	"fmt"
)
 type person struct{
   fname string 
   lname string 
   age   int 
   }
 func (p person) fullname() string {
            fmt.Printf("inside method: %p\n", &p)
	    return p.fname + p.lname 
	  }
func main() {
    p1 := person{"sangam","biradar",24}
    fmt.Printf(p1.fullname())
    fmt.Printf("\n inside method: %p \n", &p1)

}
 // p1 is reciever value for the call to fullname 
// fullname is operating on value of p1
```
try on -[Go PlayGround](https://play.golang.org/p/ptjCNcnNRsS)
note : operate on a copy of the value used to make the method call


lets me give you simple example on:(pointer)
```
package main

import (
	"fmt"
)
 type person struct{
   fname string 
   lname string 
   age   int 
   }
 func (p *person) changeage (newage int) {
            p.age = newage 
         }
	  
func main(){
    p1 := person{"sangam","biradar", 23}
    fmt.Println(p1.age)
    p1.changeage(24)
    fmt.Println(p1.age)

}
```
try on -[Go PlayGround](https://play.golang.org/p/RlGWgI-G2-7)
note: operate on the actual value used to make the method call

## which one should you use ?	

## a type’s nature
a type’s nature should dictate how you use it

## Primitive Types
Golang by default includes several pre-declared, built-in, primitive types
- boolean
- numeric 
- string 
primitive types
Pass a copy, the actual value; not a reference pointer

# Reference Types
point to some underlying data structure

Reference types
- slice
- map
- channel
- interface
- function

Header Value
When we declare a reference type, the value that is created is a header value. The header value contains a pointer to an underlying data structure. Do not use pointers with reference types. Pass a copy; the actual value. The actual value already has a reference pointer to the underlying data structure. When you give a copy of the actual value, that copy also is a pointer to the same underlying data structure. Both the copy, and the original, point to the same underlying data structure.

# Depends
Struct Types
- Use
# value
- if you don’t need to change the value
can also convey semantic meaning
- eg, Time pkg
- time is immutable

We could say this has a primitive nature

# pointer
- if you need to change the value
- typically used with structs

We could say this has a non-primitive nature


In most cases, struct types don’t exhibit a primitive nature but a nonprimitive one. In these cases, adding or removing something from the value of the type should mutate the value. When this is the case, we want to use a pointer to share the value with the rest of the program that needs it. … [ Examples: ] … When you think about time, you realize that any given point in time is not something that can change. This is exactly how the standard library implements the Time type. … Since values of type File have a non-primitive nature, they are always shared and never copied.
 ~William Kennedy
 
 The decision to use a value or pointer receiver should not being based on whether the method is mutating the receiving value. The decision should be based on the nature of the type. One exception to this guideline is when you need the flexibility that value type receivers provide when working with interface values. In these cases, you may choose to use a value receiver even though the nature of the type is nonprimitive. It’s entirely based on the mechanics behind how interface values call methods for the values stored inside of them.
 ~William Kennedy















	    
	    
	    
 












