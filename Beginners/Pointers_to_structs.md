

# Struct fields can be accessed through a struct pointer.

To access the field ``` X ```of a struct when we have the struct pointer ```p ```we could write``` (*p).X```.
However, that notation is cumbersome, so the language permits us instead to write just ```p.X```, without the explicit dereference.

```
func main() {
	z := xy{1, 2}
	p := &z
	p.X = 20
	fmt.Println(z)
}

```
[Go Program](https://play.golang.org/p/k0TOI-Ur2CN) 
```
package main

import "fmt"

type xy struct {
	X int
	Y int
}

func main() {
	z := xy{1, 2}
	p := &z
	p.X = 20
	fmt.Println(z)
}



```
