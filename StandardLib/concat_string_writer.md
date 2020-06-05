## Concatenating a string with writer

- Besides the built-in + operator, there are more ways to concatenate the string.  This recipe will describe the more performant way of concatenating strings with the bytes package and the built-in copy function.



## Create the concat_buffer.go file with the following content:
```
package main

import (
	"bytes"
	"fmt"
)

func main() {
	strings := []string{"This ", "is ", "even ",
		"more ", "performant "}
	buffer := bytes.Buffer{}
	for _, val := range strings {
		buffer.WriteString(val)
	}

	fmt.Println(buffer.String())
}



```

output: 

```
sangam:golang-daily sangam$ go run concat_buffer.go
This is even more performant 
sangam:golang-daily sangam$ 


```
## Create the concat_copy.go file with the following content:

```
package main

import (
	"fmt"
)

func main() {

	strings := []string{"This ", "is ", "even ",
		"more ", "performant "}

	bs := make([]byte, 100)
	bl := 0

	for _, val := range strings {
		bl += copy(bs[bl:], []byte(val))
	}

	fmt.Println(string(bs[:]))

}


```

output: 

```
sangam:golang-daily sangam$ go run concat_copy.go
This is even more performant 
sangam:golang-daily sangam$ 
```
## How it works...

- The steps 1 - 5 cover the use of the bytes package Buffer as a performance-friendly solution to string concatenation. The Buffer structure implements the WriteString method, which could be used to effectively concatenate the strings into an underlying byte slice.

- There is no need to use this improvement in all situations, just think about this in cases where the program is going to concatenate a big number of strings (for example, in-memory CSV exports and others).

- The built-in copy function presented in steps 6 - 8 could be used to accomplish the string concatenation. This method requires some assumption about the final string length, or it could be done on the fly. However, if the capacity of the buffer, where the result is written, is smaller than the sum of the already written part and the string to be appended, the buffer must be expanded (usually by the allocation of a new slice with bigger capacity).
