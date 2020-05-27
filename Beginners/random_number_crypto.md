
# Generate Random number with math/crypto/rand in Go - Programming in GO

Random number is useful in many application. One such example is salting password to make in more secure. 
In this tutorial, we will learn how to generate random number in Go with math/rand library.


```
package main

 import (
      "fmt"
      "math/rand"
      "time"
 )


 func main() {
    rand.Seed(time.Now().UnixNano())
    fmt.Println(rand.Intn(100))
 }
 
```
Run :
```
 go run math-rand.go
```
 
Random number is useful in many applications. From salting password to enabling secure transactions.

In this tutorial, we will learn how to generate random number in Go with crypto/rand library.
 
  
 
```
 package main

 import "encoding/binary"
 import "crypto/rand"

 func main() {
    var n int32
    binary.Read(rand.Reader, binary.LittleEndian, &n)
    println(n)
 }

```
Run :
```
 go run crytpo-rand.go
```
