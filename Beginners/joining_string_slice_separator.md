## Joining the string slice with a separator

- The recipe, Breaking the string into words, led us through the task of splitting the single string into substrings, according to defined rules. This recipe, on the other hand, describes how to concatenate the multiple strings into a single string with a given string as the separator.

- A real use case could be the problem of dynamically building a SQL select statement condition. 


## Create the join.go file with the following content:

```
        package main

        import (
          "fmt"
          "strings"
        )

        const selectBase = "SELECT * FROM user WHERE %s "

        var refStringSlice = []string{
          " FIRST_NAME = 'Jack' ",
          " INSURANCE_NO = 333444555 ",
          " EFFECTIVE_FROM = SYSDATE "}

        func main() {

          sentence := strings.Join(refStringSlice, "AND")
          fmt.Printf(selectBase+"\n", sentence)

        }



```
ouput: 
```
sangam$ go run join.go
SELECT * FROM user WHERE  FIRST_NAME = 'Jack' AND INSURANCE_NO = 333444555 AND EFFECTIVE_FROM = SYSDATE  
Biradars-MacBook-Air-4:pico sangam$


```


## Create the join_manually.go file with the following content:

```

        package main

        import (
          "fmt"
          "strings"
        )

        const selectBase = "SELECT * FROM user WHERE "

        var refStringSlice = []string{
          " FIRST_NAME = 'Jack' ",
          " INSURANCE_NO = 333444555 ",
          " EFFECTIVE_FROM = SYSDATE "}

        type JoinFunc func(piece string) string

        func main() {

          jF := func(p string) string {
            if strings.Contains(p, "INSURANCE") {
              return "OR"
            }

            return "AND"
          }
          result := JoinWithFunc(refStringSlice, jF)
          fmt.Println(selectBase + result)
        }

         func JoinWithFunc(refStringSlice []string,
                           joinFunc JoinFunc) string {
           concatenate := refStringSlice[0]
           for _, val := range refStringSlice[1:] {
             concatenate = concatenate + joinFunc(val) + val
           }
           return concatenate
        }

```
output: 

```
$ go run join_manually.go
SELECT * FROM user WHERE  FIRST_NAME = 'Jack' OR INSURANCE_NO = 333444555 AND EFFECTIVE_FROM = SYSDATE 
Biradars-MacBook-Air-4:pico sangam$ 
```

## How it works...

- For the purpose of joining the string slice into a single string, the Join function of the strings package is there. Simply, you need to provide the slice with strings that are needed to be joined. This way you can comfortably join the string slices. The use of the Join function is shown in steps 1 – 5.

- Naturally, the joining could be implemented manually by iterating over the slice. This way you can customize the separator by some more complex logic. The steps 6 – 8 just represent how the manual concatenation could be used with more complex decision logic, based on the string that is currently processed.

## There's more...

The Join function is provided by the bytes package, which naturally serves to join the slice of bytes
