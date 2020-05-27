

# Struct Fields
Struct fields are accessed using a dot.


```
func main() {
	z := xy{1, 2} //short declared variable z
	z.X = 4. // accessing X field with dot 
	fmt.Println(z.X) // print X value 
}

```
[Go Program](https://play.golang.org/p/O3BpE_D3XFr) 
```
package main

import "fmt"

type xy struct {
	X int
	Y int
}

func main() {
	z := xy{1, 2}
	z.X = 4
	fmt.Println(z.X)
}



```
