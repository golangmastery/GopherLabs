##  Single Dimensional Arrays

An array is a data structure consisting of a collection of homgeneous elements (values or variables).
Arrays are among the oldest and most important data structures, and are used to implement many other data structures, such as lists and strings. 

### 1. Creating an array

There are two ways of creating an array -

#### a. Using ```var``` keyword -

``` 
Syntax :
1. var name-of-array [size-of-array] data-type
            OR
2. var name-of-array [size-of-array] data-type { item-1, item-2, item-3...}
```
For example : In the following code snippet, we define the arrays using ``` var``` keyword.

```
package main
import "fmt"
func main() {
	var rollNo[5] int
	fmt.Println(rollNo)	
}
```
This gives the output - 

```
[0 0 0 0 0 ]
```
This happens because, by default, all the array elements are initialized with the zero value of the corresponding array type.

#### b. Using shorthand declaration :
``` 
Syntax :
name-of-array := [size-of-array] data-type {item-1, item-2,..item-N}
```
For example : In the following code snippet, we define the arrays using shorthand declaration.

```
package main
import "fmt"
func main() {
	names:= [5]string{"Amelia","Amy","Andrea","Angela","Anna"} 
	fmt.Print(names)
}
```
This gives the following output :

```
[Amelia Amy Andrea Angela Anna]
```

### 2. Accessing an array

You access an array element by referring to the index number, using the index operator [].
Considering that the array has size = n, the first element is array[0] and the last element is array[n-1].

In the following code snippet, we initialise the array elements using index operator [].

```
package main
import "fmt"
func main() {
	var rollNo[5] int
	for i := 0; i < 5; i++ {
		rollNo[i] = i+1
	}	
	fmt.Print(rollNo)
}
```
This gives the following output :

```
[1 2 3 4 5]
```

Now,in the following code snippet, we use the index operator [] to print the array elements one by one.

```
package main
import "fmt"
func main() {
	names:= [5]string{"Amelia","Amy","Andrea","Angela","Anna"} 
	for i := 0; i < 5; i++ {
		fmt.Println(names[i])
	}
}
```

This gives the following output :

```
Amelia
Amy
Andrea
Angela
Anna
```

## Mult- Dimensional Arrays

Multi-D arrays are arrays of the same type. 

### Creating and accessing elements

#### 1. Using ```var``` keyword
```
Syntax :
var name-of-array [size-1][size-2]..[size-n] data-type

(This creates an array of dimension size-1*size-2*....*size-n)
```

 For instance, 
 
 ```
 package main
import "fmt"
func main() {

    // An array of dimension 2*2
	var array [2][2] int
	array[0][0] = 00 
	array[0][1] = 01 
	array[1][0] = 02 
	array[1][1] = 03 
  
	for i:= 0; i<2; i++{ 
	for j:= 0; j<2; j++{ 
	fmt.Println(array[i][j]) 
	}
	}
}
```

Output :

```
0
1
2
3
```

#### 2. Using shorthand declaration

```
Syntax :
name-of-array := [size-1][size-2].....[size-N] [ data-type {item-1, item-2, item-3,...item-N}
```

For example :

```
https://play.golang.org/p/OdaxZZuR6SM

```

Ouput :

```
Amelia
Amy
Andrea
Angela
Anna
Bella
Bernadette
Carol
Carolyn
Monica

```

