# Extracting data from an incomplete JSON array

- This recipe contains a very specific use case, where your program consumes the JSON from an unreliable source and the JSON contains an array of objects which has the beginning token 
[ but the number of items in the array is very large, and the end of the JSON could be corrupted.

## Create the json.go file with the following content:
```
        package main

        import (
          "encoding/json"
          "fmt"
          "strings"
        )

        const js = `
          [
            {
              "name":"Axel",
              "lastname":"Fooley"
            },
            {
              "name":"Tim",
              "lastname":"Burton"
            },
            {
              "name":"Tim",
              "lastname":"Burton"
        `

        type User struct {
          Name string `json:"name"`
          LastName string `json:"lastname"`
        }

        func main() {

          userSlice := make([]User, 0)
          r := strings.NewReader(js)
          dec := json.NewDecoder(r)
          for {
            tok, err := dec.Token()
            if err != nil {
              break
            }
            if tok == nil {
              break
            }
            switch tp := tok.(type) {
              case json.Delim:
                str := tp.String()
                if str == "[" || str == "{" {
                  for dec.More() {
                    u := User{}
                    err := dec.Decode(&u)
                    if err == nil {
                      userSlice = append(userSlice, u)
                    } else {
                      break
                    }
                  }
                }
              }
            }

            fmt.Println(userSlice)
          }


```
output:
```
sangam:golang-daily sangam$ go run json.go
[{Axel Fooley} {Tim Burton}]
sangam:golang-daily sangam$ 

```

## How it works...

- Besides the Unmarshall function, the json package also contains the Decoder API. With NewDecoder, the Decoder could be created. By calling the Token method on the decoder, the underlying Reader is read and returns the Token interface. This could hold multiple values.

- One of these is the Delim type, which is a rune containing one of the {, [, ], } characters. Based on this, the beginning of the JSON array is detected. With the More method on the decoder, more objects to decode could be detected.
