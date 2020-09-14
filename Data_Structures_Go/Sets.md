A Set is a linear data structure that has a collection of values that are not repeated. A set can store unique values without any particular order.
In the real world, sets can be used to collect all tags for blog posts and conversation participants in a chat. The data can be of Boolean, integer, 
float, characters, and other types. Static sets allow only query operations, which means operations related to querying the elements. Dynamic and 
mutable sets allow for the insertion and deletion of elements. Algebraic operations such as union, intersection, difference, and subset can be defined
on the sets. The following example shows the Set integer with a map integer key and bool as a value:

```
//main package has examples shown
// in Hands-On Data Structures and algorithms with Go book
package main
// importing fmt package
import (
 "fmt"
)
//Set class
type Set struct {
 integerMap map[int]bool
}
//create the map of integer and bool
func (set *Set) New(){
 set.integerMap = make(map[int]bool)
}

```

The `AddElement`, `DeleteElement`, `ContainsElement`, `Intersect`, `Union`, and main methods are discussed in the following sections

## The AddElement method

The `AddElement` method adds the element to a set. In the following code snippet, the `AddElement` method of the Set class adds the element to
`integerMap` if the element is not in the Set. The `integerMap` element has the key integer and value as bool, as shown in the following code:

```

// adds the element to the set
func (set *Set) AddElement(element int){
 if !set.ContainsElement(element) {
  set.integerMap[element] = true
 }
}

```

The example output after invoking the AddElement method with parameter 2 is as follows. The check is done if there is an element with value 2. If there is no element,
the map is set to true with the key as 2:

```
Add element method 
does the set have element : false 
set has the current element true 
initial set &{map[1:true 2:true]}
true

```

Let's take a look at the DeleteElement method in the next section.

## The DeleteElement method

The DeleteElement method deletes the element from integerMap using the delete method. This method removes the element
from the integerMap of the set, as follows:

```

//deletes the element from the set
func (set *Set) DeleteElement(element int) {
    delete(set.integerMap,element)
}

```

## The ContainsElement method

The ContainsElement method of the Set class checks whether or not the element exists in integerMap. The integerMap element 
is looked up with a key integer element, as shown in the following code example:

```

//checks if element is in the set
func (set *Set) ContainsElement(element int) bool{
 var exists bool
 _, exists = set.integerMap[element]
 return exists
}

```

## The main method – contains element

 the main method creates Set, invokes the New method, and adds elements 1 and 2. The check is done if element 1 exists in the set:


```
// main method
func main() {
    var set *Set
    set = &Set{}
    set.New()
    set.AddElement(1)
    set.AddElement(2)
    fmt.Println(set)
    fmt.Println(set.ContainsElement(1))
}


```
Run the following command to execute the set.go file:

```
go run set.go

```


## The InterSect method

 the InterSect method on the Set class returns an intersectionSet that consists of the intersection of set and anotherSet. The set 
class is traversed through integerMap and checked against another Set to see if any elements exist:

```
//Intersect method returns the set which intersects with anotherSet

func (set *Set) Intersect(anotherSet *Set) *Set{
 var intersectSet = & Set{}
 intersectSet.New()
 var value int
 for(value,_ = range set.integerMap){
   if anotherSet.ContainsElement(value) {
    intersectSet.AddElement(value)
   }
 }
 return intersectSet 
}


```



