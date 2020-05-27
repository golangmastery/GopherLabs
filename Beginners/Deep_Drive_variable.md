

# deep drive on variables 


```

package main

import "fmt"

func main() {
	var message string
	message = "Hello World."
	fmt.Println(message)
}

```

lets start with the simple program in which we will going to declare variable call message with string type and we will assign 
value to var message and we will print that variable if you go variable var which is assigned to message thats hello world .
wow! you successfully executed !!


# 2.deep drive on variables - programming in go

so you got ideas on variable lets declare more than one variable and print values to better understanding 

```
package main

import "fmt"

func main() {
	var message string
	var a, b, c int
	a = 1

	message = "Hello World!"

	fmt.Println(message, a, b, c)
}

```

# 3.deep drive on variables - programming in go

in this program we are init many variable at once if your beginner to golang its better to try out !!

```
package main

import "fmt"

func main() {

	var message = "Hello World!"
	var a, b, c int = 1, 2, 3

	fmt.Println(message, a, b, c)
}
```
# 4.deep drive on variables - programming in go

in this program we are declaring variable without declaring variable type lets check it out:-

```
package main

import "fmt"

func main() {

	var message = "Hello World!"
	var a, b, c = 1, 2, 3

	fmt.Println(message, a, b, c)
}
```
# 5.deep drive on variables - programming in go

in the above program we just given same value for varible lets try some diff values ``` var a, b, c = 1, false, 3``` like this 
try out this program for better understandending 

```
package main

import "fmt"

func main() {

	var message = "Hello World!"
	var a, b, c = 1, false, 3

	fmt.Println(message, a, b, c)
}
```
# 6.deep drive on variables - programming in go

we are lazy programmer !! haha !!

try out short variable declarations so in this we don't need to use the var syntax or its type all right !! 
```:=``` use this short variable declaration method but condition is you can only do this inside a func

```
package main

import "fmt"

func main() {

	// you can only do this inside a func
	message := "Hello World!"
	a, b, c := 1, false, 3
	d := 4
	e := true

	fmt.Println(message, a, b, c, d, e)
}
```
# 7.deep drive on variables - programming in go

look like now everyone is doing good !! with variable 

in this program we are declaring folllowing variable with respective values 


```
a -  this is stored in the variable a
b -  stored in b
c -  stored in c
d -  stored in d

```
declare a,b,c,d variable outside of main function with var syntax 
```
e -  42
f -  43
g -  stored in g
h -  stored in h
i -  stored in i
j -  44.7
k -  true
l -  false
m -  109
n -  n
o -  o
```
and declare above variable with short variable declaration and print variable 
```
package main

import "fmt"

var a = "this is stored in the variable a"     // package scope
var b, c string = "stored in b", "stored in c" // package scope
var d string                                   // package scope

func main() {

	d = "stored in d" // declaration above; assignment here; package scope
	var e = 42        // function scope - subsequent variables have func scope:
	f := 43
	g := "stored in g"
	h, i := "stored in h", "stored in i"
	j, k, l, m := 44.7, true, false, 'm' // single quotes
	n := "n"                             // double quotes
	o := `o`                             // back ticks

	fmt.Println("a - ", a)
	fmt.Println("b - ", b)
	fmt.Println("c - ", c)
	fmt.Println("d - ", d)
	fmt.Println("e - ", e)
	fmt.Println("f - ", f)
	fmt.Println("g - ", g)
	fmt.Println("h - ", h)
	fmt.Println("i - ", i)
	fmt.Println("j - ", j)
	fmt.Println("k - ", k)
	fmt.Println("l - ", l)
	fmt.Println("m - ", m)
	fmt.Println("n - ", n)
	fmt.Println("o - ", o)
}
```
## deep drive on variables - programming in go
# if you want to do more hands on try out following programms 

```
package main

import "fmt"

var name = "sangam"

func main() {
	fmt.Println("Hello ", name)
}
```
## another way 
```
package main

import "fmt"

func main() {
	name := "sangam"
	fmt.Println("Hello ", name)
}
```
## another way 
```
package main

import "fmt"

func main() {
	name := `sangam` // back-ticks work like double-quotes
	fmt.Println("Hello ", name)
}
```
