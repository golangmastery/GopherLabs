## Finding the substring in a string

- Finding the substring in a string is one of the most common tasks for developers. Most of the mainstream languages implement this in a standard library. Go is not an exception. This recipe describes the way Go implements this.


## Create the main.go file with the following content:
```
package main

import (
	"fmt"
	"strings"
)

const refString = "Mary had a little lamb"

func main() {

	lookFor := "lamb"
	contain := strings.Contains(refString, lookFor)
	fmt.Printf("The \"%s\" contains \"%s\": %t \n", refString,
		lookFor, contain)

	lookFor = "wolf"
	contain = strings.Contains(refString, lookFor)
	fmt.Printf("The \"%s\" contains \"%s\": %t \n", refString,
		lookFor, contain)

	startsWith := "Mary"
	starts := strings.HasPrefix(refString, startsWith)
	fmt.Printf("The \"%s\" starts with \"%s\": %t \n", refString,
		startsWith, starts)

	endWith := "lamb"
	ends := strings.HasSuffix(refString, endWith)
	fmt.Printf("The \"%s\" ends with \"%s\": %t \n", refString,
		endWith, ends)

}
```
output:- 
```
Biradars-MacBook-Air-4:Documents sangam$ cd golang-daily/
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
The "Mary had a little lamb" contains "lamb": true 
The "Mary had a little lamb" contains "wolf": false 
The "Mary had a little lamb" starts with "Mary": true 
The "Mary had a little lamb" ends with "lamb": true 
Biradars-MacBook-Air-4:golang-daily sangam$ 
```

## How it works...

- The Go library strings contain functions to handle the string operations. This time the function Contains could be used. The Contains function simply checks whether the string has a given substring. In fact, the function Index is used in Contains function.

- To check whether the string begins with the substring, the HasPrefix function is there. To check whether the string ends with the substring, the function HasSuffix will work.

- In fact, the Contains function is implemented by use of the Index function from the same package. As you can guess, the actual implementation works like this: if the index of the given substring is greater than -1, the Contains function returns true. 

- The HasPrefix and HasSuffix functions work in a different way: the internal implementation just checks the length of both the string and substring, and if they are equal or the string is longer, the required part of the string is compared.
