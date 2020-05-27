## Breaking the string into words

- Breaking the string into words could be tricky. First, decide what the word is, as well as what the separator is, and if there is any whitespace or any other characters.  After these decisions have been made, you can choose the appropriate function from the strings package. This recipe will describe common cases.

## Create the main.go file with the following content:
```
package main

import (
	"fmt"
	"strings"
)

const refString = "Mary had a little lamb"

func main() {

	words := strings.Fields(refString)
	for idx, word := range words {
		fmt.Printf("Word %d is: %s\n", idx, word)
	}

}

```


output: 
```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
Word 0 is: Mary
Word 1 is: had
Word 2 is: a
Word 3 is: little
Word 4 is: lamb
Biradars-MacBook-Air-4:golang-daily sangam$ 

```
## Create the main.go file with the following content:

```
        package main

        import (
          "fmt"
          "strings"
        )

        const refString = "Mary_had a little_lamb"

        func main() {

          words := strings.Split(refString, "_")
          for idx, word := range words {
            fmt.Printf("Word %d is: %s\n", idx, word)
          }

        }


```


output:
```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
Word 0 is: Mary
Word 1 is: had a little
Word 2 is: lamb
Biradars-MacBook-Air-4:golang-daily sangam$ 

```

## Create another file called main.go with the following content:

```
        package main

        import (
          "fmt"
          "strings"
         )

         const refString = "Mary*had,a%little_lamb"

         func main() {

           // The splitFunc is called for each
           // rune in a string. If the rune
           // equals any of character in a "*%,_"
           // the refString is split.
           splitFunc := func(r rune) bool {
             return strings.ContainsRune("*%,_", r)
           }

           words := strings.FieldsFunc(refString, splitFunc)
           for idx, word := range words {
             fmt.Printf("Word %d is: %s\n", idx, word)
           }

        }



```
output :
```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
Word 0 is: Mary
Word 1 is: had
Word 2 is: a
Word 3 is: little
Word 4 is: lamb
Biradars-MacBook-Air-4:golang-daily sangam$ 

```

## Create another file called main.go with the following content:
this problems asked in many interviews to understand your basics conects around strings 
```

        package main

        import (
          "fmt"
          "regexp"
        )

        const refString = "Mary*had,a%little_lamb"

        func main() {

          words := regexp.MustCompile("[*,%_]{1}").Split(refString, -1)
          for idx, word := range words {
            fmt.Printf("Word %d is: %s\n", idx, word)
          }

        }


```


output: 
```
Biradars-MacBook-Air-4:golang-daily sangam$ go run main.go
Word 0 is: Mary
Word 1 is: had
Word 2 is: a
Word 3 is: little
Word 4 is: lamb
Biradars-MacBook-Air-4:golang-daily sangam$ 


```

## How it works...

The simplest form of how to split the string into words considers any whitespace as a separator. In detail, the whitespace is defined by the IsSpace function in the unicode package:
```
'\t', '\n', '\v', '\f', '\r', ' ', U+0085 (NEL), U+00A0 (NBSP). 

```

- The Fields function of the strings package could be used to split the sentence by the whitespace chars as mentioned earlier. The steps 1 – 5 cover this first simple case.

- If any other separator is needed, the Split function comes into play. Splitting by another separator is covered in steps 6 – 8. Just note that the whitespace in the string is omitted.

- If you need a more complex function to decide whether to split the string at a given point, FieldsFunc could work for you. One of the function's argument is the function that consumes the rune of the given string and returns true if the string should split at that point.  This option is covered by steps 9 – 11.

- The regular expression is the last option mentioned in the example. The Regexp structure of the regexp package contains the Split method, which works as you would expect. It splits the string in the place of the matching group. This approach is used in steps 12 – 14.

## There's more...

- The strings package also provides the various SplitXXX functions that could help you to achieve more specific tasks.
