
## Indenting a text document

- The previous recipe depicts how to do string padding and whitespace trimming. This one will guide you through the indentation and unindentation of a text document. Similar principles from the previous recipes will be used.


## Create the file main.go with the following content:

```
         package main

         import (
           "fmt"
           "strconv"
           "strings"
           "unicode"
         )

         func main() {

           text := "Hi! Go is awesome."
           text = Indent(text, 6)
           fmt.Println(text)

           text = Unindent(text, 3)
           fmt.Println(text)

           text = Unindent(text, 10)
           fmt.Println(text)

           text = IndentByRune(text, 10, '.')
           fmt.Println(text)

         }

         // Indent indenting the input by given indent and rune
         func IndentByRune(input string, indent int, r rune) string {
           return strings.Repeat(string(r), indent) + input
         }

         // Indent indenting the input by given indent
         func Indent(input string, indent int) string {
           padding := indent + len(input)
           return fmt.Sprintf("% "+strconv.Itoa(padding)+"s", input)
         }

         // Unindent unindenting the input string. In case the
         // input is indented by less than "indent" spaces
         // the min of this both is removed.
         func Unindent(input string, indent int) string {

           count := 0
           for _, val := range input {
             if unicode.IsSpace(val) {
               count++
             }
             if count == indent || !unicode.IsSpace(val) {
               break
             }
           }

           return input[count:]
         }

```
output:
```
sangam:golang-daily sangam$ go run main.go
      Hi! Go is awesome.
   Hi! Go is awesome.
Hi! Go is awesome.
..........Hi! Go is awesome.
sangam:golang-daily sangam$ 
```

## How it works...

- The indentation is as simple as padding. In this case, the same formatting option is used. The more readable form of the indent implementation could use the Repeat function of the strings package. The IndentByRune function in the preceding code applies this approach.

- Unindenting, in this case, means removing the given count of leading spaces. The implementation of Unindent in the preceding code removes the minimum number of leading spaces or given indentation. 
