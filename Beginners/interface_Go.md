
# What is interface ?

Go is not a ‘classic’ OO language: 
it doesn’t know the concept of classes and inheritance.
However it does contain the very flexible concept of interfaces, with which a lot of aspects of object-orientation can be made available. Interfaces in Go provide a way to specify the behavior of an object: 
if something can do this, then it can be used here.
An interface defines a set of methods (the method set), but these methods do not contain code: they are not implemented ( they are abstract). Also an interface cannot contain variables.
An interface is declared in the format:
where Namer is an interface type.
 ``` 
  type Namer interface { 
     Method1(param_list) 
     return_type Method2(param_list) 
    return_type ...
    }
   ``` 
The name of an interface is formed by the method name plus the [e]r suffix, such as Printer, Reader, Writer, Logger, Converter, etc., thereby giving an active noun as a name. 
A less used alternative (when ..er is not so appropriate) is to end it with able like in Recoverable, or to start it with an I (more like in .NET or Java) .
Interfaces in Go are short, they usually have from 0—max 3 methods.
Unlike in most OO languages, in Go interfaces can have values, a variable of the interface type or an interface value: 

`var ai Namer`

ai is a multiword data structure with an uninitialized value of nil. Allthough not completely the same thing, 
it is in essence a pointer. So pointers to interface values are illegal; 
they would be completely useless and give rise to errors in code.

```
package main

import (
    "fmt"
)

func myFunc(a interface{}) {
    fmt.Println(a)
}

func main() {
    var my_age int
    my_age = 25

    myFunc(my_age)
}
```

Its table of method pointers is build through the runtime reflection capability.
Types (like structs) can have the method set of the interface implemented;
the implementation contains for each method real code how to act on a variable of that type: they implement the interface, the method set forms the interface of that type. 
A variable of a type that implements the interface can be assigned to ai (the receiver value), the method table then has pointers to the implemented interface methods. Both of these of course change when a variable of another type (that also implements the interface) is assigned to ai.

- A type doesn’t have to state explicitly that it implements an interface: interfaces are satisfied implicitly.<br>
- Multiple types can implement the same interface.<br>
- A type that implements an interface can also have other functions. <br>
- A type can implement many interfaces.<br>

- An interface type can contain a reference to an instance of any of the types that implement the interface (an interface has what is called a dynamic type)
Even if the interface was defined later than the type, in a different package, compiled separately: 
if the object implements the methods named in the interface, then it implements the interface.

- All these properties allow for a lot of flexibility.

```
package main

import "fmt"
      type Shaper interface {
               Area() float32
    }
type Square struct {
side float32
   }
func (sq *Square) Area() float32 {
         return sq.side * sq.side
}
func main() {
         sq1 := new(Square)
         sq1.side = 5
 // var areaIntf Shaper
// areaIntf = sq1
// shorter, without separate declaration:
// areaIntf := Shaper(sq1)
// or even:
areaIntf := sq1
fmt.Printf("The square has area: %f\n", areaIntf.Area())
 }
```

Try Out -[GO Playground](https://play.golang.org/p/aitliEmakxG)


The program defines a struct Square and an interface Shaper, with one method `Area()`.
In `main()`an instance of Square is constructed. Outside of main we have an `Area()` method with a
receiver type of Square where the area of a square is calculated: the struct Square implements the interface Shaper.
Because of this we can assign a variable of type Square to a variable of the interface type:
```areaIntf = sq1```
Now the interface variable contains a reference to the Square variable and through it we can call the method `Area()` on Square. Of course you could call the method immediately on the Square instance sq1. `Area()`, but the novel thing is that we can call it on the interface instance, thereby generalizing the call. 
The interface variable both contains the value of the receiver instance and a pointer to the appropriate method in a method table.

```
package main
import "fmt"
    
type stockPosition struct {
           ticker string
           sharePrice float32
           count float32
}
// method to determine the value of a stock position 

func (s stockPosition) getValue() float32 {
     return s.sharePrice * s.count
}
type car struct {
     make string
     model string
     price float32
}
// method to determine the value of a car 

func (c car) getValue() float32 {
     return c.price
}
// contract that defines different things that have value

type valuable interface {
     getValue() float32
}
// anything that satisfies the “valuable” interface is accepted 

func showValue(asset valuable) {
     fmt.Printf("Value of the asset is %f\n", asset.getValue())
}
func main() {
     var o valuable = stockPosition{ "GOOG", 577.20, 4 }
     showValue(o)
     o = car{ "BMW", "M3", 66500 }
     showValue(o)
}
```
- Try Out: -[Go PlayGround](https://play.golang.org/p/QaEguA-DFNM)

                     
