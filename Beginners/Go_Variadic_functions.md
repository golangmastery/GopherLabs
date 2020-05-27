
# What is variadic function?

variadic function is simple function which accepts many arguments.and those arguments store parameter as slicen type.

```
func f(elem ...Type) 
```

A typical syntax of a variadic function looks like above. ... operator called as pack operator instructs go to store all arguments of type Type in elem parameter. With this syntax, go creates elem variable of the type []Type which is a slice. 
Hence, all arguments passed to this function is stored in a elem slice.


```
package main

import "fmt"

func getMultiples(factor int, args ...int) []int {
	multiples := make([]int, len(args))

	for index, val := range args {
		multiples[index] = val * factor
	}

	return multiples
}

func main() {
	s := []int{10, 20, 30}

	// get multiples of 2, pass parameters from slice using `unpack` operator
	mult1 := getMultiples(2, s...)

	// get multiples of 3
	mult2 := getMultiples(3, 1, 2, 3, 4)

	fmt.Println(mult1)
	fmt.Println(mult2)
}

```
try out -[Go Playground](https://play.golang.org/p/BgU6H9orhrn)

in the above program `func getMultiples(factor int, args ...int) []int {` this is variadic fuction with two types 
variable in which one is factor with data type int and another is ( unpack operator ) which means n number of parameters.

`mult1` and `mult2` is two shore declartion variable which execute `getmultiples` variadic function and first argument is factor 

