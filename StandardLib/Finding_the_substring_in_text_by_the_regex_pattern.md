## Finding the substring in text by the regex pattern

- There are always tasks such as validating the input, searching the document for any information, or even cleaning up a given string from unwanted escape characters. For these cases, regular expressions are usually used.

- The Go standard library contains the regexp package, which covers the operations with regular expressions.

## Create the main.go file with the following content:

```
package main

import (
	"fmt"
	"regexp"
)

const refString = `[{ \"email\": \"email@example.com\" \"phone\": 555467890},
{ \"email\": \"other@domain.com\" \"phone\": 555467890}]`

func main() {

	// This pattern is simplified for brevity
	emailRegexp := regexp.MustCompile("[a-zA-Z0-9]{1,}@[a-zA-Z0-9]{1,}\\.[a-z]{1,}")
	first := emailRegexp.FindString(refString)
	fmt.Println("First: ")
	fmt.Println(first)

	all := emailRegexp.FindAllString(refString, -1)
	fmt.Println("All: ")
	for _, val := range all {
		fmt.Println(val)
	}

}



```
output:- 

```
sangam:golang-daily sangam$ go run main.go
First: 
email@example.com
All: 
email@example.com
other@domain.com
sangam:golang-daily sangam$

```

## How it works...

- The FindString or FindAllString functions are the simplest ways to find the matching pattern in the given string. The only difference is that the FindString method of Regexp will return only the first occurrence. On the other hand, the FindAllString, as the name suggests, returns a slice of strings with all occurrences.

- The Regexp type offers a rich set of FindXXX methods. This recipe describes only the String variations that are usually most useful. Note that the preceding code uses the MustCompile function of the regexp package, which panics if the compilation of the regular expression fails.
