# Two-dimensional slices

Two-dimensional slices are descriptors of a two-dimensional array.
A two-dimensional slice is a contiguous section of an array that is stored away from the slice itself. 
It holds references to an underlying array. A two-dimensional slice will be an array of arrays, 
while the capacity of a slice can be increased by creating a new slice and copying the contents of the initial 
slice into the new one. This is also referred to as a slice of slices. The following is an example of a two-dimensional array.
A 2D array is created and the array elements are initialized with values.

```

package main
// importing fmt package
import (
"fmt"
)
// main method
func main() {
var TwoDArray [8][8]int
TwoDArray[3][6] = 18
TwoDArray[7][4] = 3
fmt.Println(TwoDArray)
}


```
output :-
```
 sangam$ go run 2darray.go
[[0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0] [0 0 0 0 0 0 18 0] 
[0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0] [0 0 0 0 3 0 0 0]]
```

For dynamic allocation, we use slice of slices. 
In the following code, slice of slices is explained as two-dimensional slices— twodslices.go:
```
sangam$ cat twodslices.go

package main

// importing fmt package
import (
	"fmt"
)

// main method
func main() {

	var rows int
	var cols int

	rows = 7
	cols = 9
	var twodslices = make([][]int, rows)

	var i int

	for i = range twodslices {

		twodslices[i] = make([]int, cols)
	}

	fmt.Println(twodslices)
}

```
output :
```
 sangam$ go run twodslices.go
[[0 0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0 0] [0 0 0 0 0 0 0 0 0]]


```

The append method on the slice is used to append new elements to the slice. If the slice capacity has reached the size of the underlying array, then append increases the size by creating a new underlying array and adding the new element. slic1 is a sub slice of arr starting from zero to 3 (excluded), while slic2 is a sub slice of arr starting from 1 (inclusive) to 5 (excluded). In the following snippet, the append method calls on slic2 to add a new 12 element (append_slice.go):

```

package main

// importing fmt package
import (
	"fmt"
)

// main method
func main() {

	var arr = []int{5, 6, 7, 8, 9}
	var slic1 = arr[:3]
	fmt.Println("slice1", slic1)
	var slic2 = arr[1:5]

	fmt.Println("slice2", slic2)
	var slic3 = append(slic2, 12)

	fmt.Println("slice3", slic3)

}

```
output:
```
sangam$ go run append_slice.go 
slice1 [5 6 7]
slice2 [6 7 8 9]
slice3 [6 7 8 9 12]

```
