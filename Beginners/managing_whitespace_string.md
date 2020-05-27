## Managing whitespace in a string

- The string input could contain too much whitespace, too little whitespace, or unsuitable whitespace chars. This recipe includes tips on how to manage these and format the string to your needs. 

## Create a file named  main.go with the following content:

```
        package main

        import (
          "fmt"
          "math"
          "regexp"
          "strconv"
          "strings"
        )

        func main() {

          stringToTrim := "\t\t\n Go \tis\t Awesome \t\t"
          trimResult := strings.TrimSpace(stringToTrim)
          fmt.Println(trimResult)

          stringWithSpaces := "\t\t\n Go \tis\n Awesome \t\t"
          r := regexp.MustCompile("\\s+")
          replace := r.ReplaceAllString(stringWithSpaces, " ")
          fmt.Println(replace)

          needSpace := "need space"
          fmt.Println(pad(needSpace, 14, "CENTER"))
          fmt.Println(pad(needSpace, 14, "LEFT"))
        }

        func pad(input string, padLen int, align string) string {
          inputLen := len(input)

          if inputLen >= padLen {
            return input
          }

          repeat := padLen - inputLen
          var output string
          switch align {
            case "RIGHT":
              output = fmt.Sprintf("% "+strconv.Itoa(-padLen)+"s", input)
            case "LEFT":
              output = fmt.Sprintf("% "+strconv.Itoa(padLen)+"s", input)
            case "CENTER":
              bothRepeat := float64(repeat) / float64(2)
              left := int(math.Floor(bothRepeat)) + inputLen
              right := int(math.Ceil(bothRepeat))
              output = fmt.Sprintf("% "+strconv.Itoa(left)+"s% 
                                   "+strconv.Itoa(right)+"s", input, "")
          }
          return output
        }

```
output:

```
sangam:golang-daily sangam$ go run main.go
Go 	is	 Awesome
 Go is Awesome 
  need space  
    need space
sangam:golang-daily sangam$ 

```
## How it works...

- Trimming the string before it is handled by the code is pretty common practice, and as the preceding code demonstrates, it is easily done by the standard Go library. The strings library also provides more variations of the TrimXXX function, which also allows the trimming of other chars from the string.

- To trim the leading and ending whitespace, the TrimSpace function of the strings package can be used. This typifies the following part of a code, which was also included in the example earlier:
```
stringToTrim := "\t\t\n Go \tis\t Awesome \t\t"
stringToTrim = strings.TrimSpace(stringToTrim)
```
- The regex package is suitable for replacing multiple spaces and tabs, and the string can be prepared for further processing this way. Note that, with this method, the break lines are replaced with a single space. 

- This part of the code represents the use of the regular expression to replace all multiple whitespaces with a single space:

```
r := regexp.MustCompile("\\s+")
replace := r.ReplaceAllString(stringToTrim, " ")
```
- Padding is not an explicit function for the strings package, but it can be achieved by the Sprintf function of the fmt package. The pad function in code uses the formatting pattern % <+/-padding>s and some simple math to find out the padding. Finally, the minus sign before the padding number works as the right pad, and the positive number as the left pad.
