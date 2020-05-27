Go Slice is an abstraction over Go Array. Multiple data elements of the same type are allowed by Go arrays. 
The definition of variables that can hold several data elements of the same type are allowed by Go Array,
but it does not have any provision of inbuilt methods to increase its size in Go. 
This shortcoming is taken care of by Slices. A Go slice can be appended to elements after the capacity has reached its size. 
Slices are dynamic and can double the current capacity in order to add more elements.


The len() function gives the current length of slice, and the capacity of slice can be obtained using the cap() function. 
The following code sample shows the basic slice creation and appending a slice (basic_slice.go):

```
// importing fmt package
import (
	"fmt"
)

// main method
func main() {

	var slice = []int{1, 3, 5, 6}

	slice = append(slice, 8)

	fmt.Println("Capacity", cap(slice))

	fmt.Println("Length", len(slice))
}

```
output:
```
sangam$ go run basic_slice.go 
Capacity 8
Length 5
```
## Slice Function 

Slices are passed by referring to functions. Big slices can be passed to functions without impacting performance. 
Passing a slice as a reference to a function is demonstrated in the code as follows (slices.go):


sangam$ cat slices.go 
```
package main

// importing fmt package
import (
	"fmt"
)

//twiceValue method given slice of int type
func twiceValue(slice []int) {

	var i int
	var value int

	for i, value = range slice {

		slice[i] = 2 * value

	}

}

// main method
func main() {

	var slice = []int{1, 3, 5, 6}
	twiceValue(slice)

	var i int

	for i = 0; i < len(slice); i++ {

		fmt.Println("new slice value", slice[i])
	}
}

```
output:
```
sangam$ go run slices.go 
new slice value 2
new slice value 6
new slice value 10
new slice value 12

```
