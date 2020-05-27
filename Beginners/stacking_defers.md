
# Stacking defers
Deferred function calls are pushed onto a stack. When a function returns, 
its deferred calls are executed in last-in-first-out order.

lets write a program to count numbers from ```1``` to ```9```
```
package main

import "fmt"

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		 fmt.Println(i)
	}

	fmt.Println("done")
}
```
[Go Playground](https://play.golang.org/p/aOJHy5FgZXF)

 Stacking defers - use defer  ```	 defer fmt.Println(i). ``` because of defer its give you output of last result in first thats
known as last-in-first out manner 
```
package main

import "fmt"

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		 defer fmt.Println(i)
	}

	fmt.Println("done")
}
```
[Go Playground](https://play.golang.org/p/aioV0JViI9Z)

Important:
```
	for i := 0; i < 10; i++ {
		 defer fmt.Println(i)
	}
```


output:
```
counting
done
9
8
7
6
5
4
3
2
1
0
```
