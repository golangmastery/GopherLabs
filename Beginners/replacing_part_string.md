## Replacing part of the string

- Another very common task related to string processing is the replacement of the substring in a string. Go standard library provide the Replace function and Replacer type for the replacement of multiple strings at once.



## Create the replace.go file with the following content:

```
        package main

        import (
         "fmt"
         "strings"
        )

        const refString = "Mary had a little lamb"
        const refStringTwo = "lamb lamb lamb lamb"

        func main() {
          out := strings.Replace(refString, "lamb", "wolf", -1)
          fmt.Println(out)

          out = strings.Replace(refStringTwo, "lamb", "wolf", 2)
          fmt.Println(out)
        }

```

output: 

```
sangam:golang-daily sangam$ go run replace.go
Mary had a little wolf
wolf wolf lamb lamb
sangam:golang-daily sangam$ 
```
```

## Create the replacer.go file with the following content:

```
        package main

        import (
          "fmt"
          "strings"
        )

        const refString = "Mary had a little lamb"

        func main() {
          replacer := strings.NewReplacer("lamb", "wolf", "Mary", "Jack")
          out := replacer.Replace(refString)
          fmt.Println(out)
        }
  ```      

output:
```
sangam:golang-daily sangam$ go run replacer.go
Jack had a little wolf
sangam:golang-daily sangam$ 
```
## Create the regexp.go file with the following content:

```
        package main

        import (
          "fmt"
          "regexp"
        )

        const refString = "Mary had a little lamb"

        func main() {
          regex := regexp.MustCompile("l[a-z]+")
          out := regex.ReplaceAllString(refString, "replacement")
          fmt.Println(out)
        }

```
output:

```
sangam:golang-daily sangam$ go run regexp.go
Mary had a replacement replacement
sangam:golang-daily sangam$ 


```

## How it works...

- The Replace function of a strings package is widely used for simple replacement. The last integer argument defines how many replacements will be done (in case of -1, all strings are replaced. See the second use of Replace, where only the first two occurrences are replaced.) The use of the Replace function is presented in steps 1 - 5.

- Besides the Replace function, the Replacer structure also has the WriteString method. This method will write to the given writer with all replacements defined in Replacer.  The main purpose of this type is its reusability. It can replace multiple strings at once and it is safe for concurrent use; see steps 6 - 8.

- The more sophisticated method of replacing the substring, or even the matched pattern, is naturally the use of the regular expression. The Regex type pointer method ReplaceAllString could be leveraged for this purpose. Steps 9 - 11 illustrate the use of the regexp package.
There's more...

- If more complex logic for the replacement is needed, the regexp package is probably the one that should be used.
