
# Prefix Suffix 

HasPrefix tests whether the string s begins with prefix:<br>
      ```strings.HasPrefix(s, prefix string) bool``` <br>
HasSuffix tests whether the string s end with suffix:<br>
     ``` strings.HasSuffix(s, suffix string) bool```
```
package main
import ( 
 "fmt"
 "strings"   
 )
func main() {
var str string = "This is an example of a string"
fmt.Printf("T/F? Does the string \"%s\" have prefix %s? ", str, "Th") 
fmt.Printf("%t\n", strings.HasPrefix(str, "Th"))
}
```

Output: ```T/F? Does the string “This is an example of a string” have prefix Th? True```



[Go Playground](https://play.golang.org/p/ZQW-WzSkzLS)
