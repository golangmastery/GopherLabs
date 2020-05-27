
Arrays are the most famous data structures in different programming languages. 
Different data types can be handled as elements in arrays such as int, float32, double, and others.
The following code snippet shows the initialization of an array (arrays.go):

````
var arr = [5]int {1,2,4,5,6}

````
An array's size can be found with the len() function  A for loop is used for accessing all the elements in an array,
as follows:

```

var i int
for i=0; i< len(arr); i++ {
    fmt.Println("printing elements ",arr[i]
}

```
In the following code snippet, the range keyword is explained in detail. 
The range keyword can be used to access the index and value for each element:

```
var value int
for i, value = range arr{
    fmt.Println(" range ",value)
}

```
The _ blank identifier is used if the index is ignored. The following code shows how a _ blank identifier can be used:
```
for _, value = range arr{
    fmt.Println("blank range",value)
}
```
create file `array.go` with following content :

```

package main

// importing fmt package
import (
	"fmt"
)

// main method
func main() {

	var arr = [5]int{1, 2, 4, 5, 6}

	var i int
	for i = 0; i < len(arr); i++ {

		fmt.Println("printing elements ", arr[i])

	}

	var value int
	for i, value = range arr {

		fmt.Println(" range ", value)

	}

	for _, value = range arr {

		fmt.Println("blank range", value)

	}

}


```


```

sangam$ go run arrays.go
printing elements  1
printing elements  2
printing elements  4
printing elements  5
printing elements  6
 range  1
 range  2
 range  4
 range  5
 range  6
blank range 1
blank range 2
blank range 4
blank range 5
blank range 6




```
