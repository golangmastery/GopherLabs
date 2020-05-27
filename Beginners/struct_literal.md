
# struct literal

A struct literal denotes a newly allocated struct value by listing the values of its fields.
You can list just a subset of fields by using the Name: syntax. (And the order of named fields is irrelevant.)
The special prefix & returns a pointer to the struct value.

```
var (
	z1 = xy{1, 2}  // has type xy. z1={1,2}
	z2 = xy{X: 1}  // Y:0 is implicit z2={1,0}
	z3 = xy{}      // X:0 and Y:0 z3={0,0}
	p  = &xy{1, 2} // has type *xy  p={1,2}
)
```

[Go Playground](https://play.golang.org/p/P5whnHh57Zn)
```
package main

import "fmt"

type xy struct {
	X, Y int
}

var (
	z1 = xy{1, 2}  // has type xy
	z2 = xy{X: 1}  // Y:0 is implicit
	z3 = xy{}      // X:0 and Y:0
	p  = &xy{1, 2} // has type *xy
)

func main() {
	fmt.Println(z1, p, z2, z3)
}
```

