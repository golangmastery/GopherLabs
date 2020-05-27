
# Converting between binary, octal, decimal, and hexadecimal

- In some cases, the integer values can be represented by other than decimal representations. 
The conversion between these representations is easily done with the use of the strconv package

## Create the main.go file with the following content:
```
        package main

        import (
          "fmt"
          "strconv"
        )

        const bin = "10111"
        const hex = "1A"
        const oct = "12"
        const dec = "10"
        const floatNum = 16.123557

        func main() {

          // Converts binary value into hex
          v, _ := ConvertInt(bin, 2, 16)
          fmt.Printf("Binary value %s converted to hex: %s\n", bin, v)

          // Converts hex value into dec
          v, _ = ConvertInt(hex, 16, 10)
          fmt.Printf("Hex value %s converted to dec: %s\n", hex, v)

          // Converts oct value into hex
          v, _ = ConvertInt(oct, 8, 16)
          fmt.Printf("Oct value %s converted to hex: %s\n", oct, v)

          // Converts dec value into oct
          v, _ = ConvertInt(dec, 10, 8)
          fmt.Printf("Dec value %s converted to oct: %s\n", dec, v)

          //... analogically any other conversion
          // could be done.

        }

        // ConvertInt converts the given string value of base
        // to defined toBase.
        func ConvertInt(val string, base, toBase int) (string, error) {
          i, err := strconv.ParseInt(val, base, 64)
          if err != nil {
            return "", err
          }
          return strconv.FormatInt(i, toBase), nil
        }

```
output:
```
sangam:golang-daily sangam$ go run main.go
Binary value 10111 converted to hex: 17
Hex value 1A converted to dec: 26
Oct value 12 converted to hex: a
Dec value 10 converted to oct: 12
sangam:golang-daily sangam$ 
```
## How it works...

- The strconv package provides the functions ParseInt and FormatInt which are the, let's say, complementary functions. The function ParseInt is able to parse the integer number in any base representation. The function FormatInt, on the other hand, can format the integer into any given base. 

- Finally, it is possible to parse the string representation of the integer to the built-in int64 type and subsequently, format the string of the parsed integer into the given base representation.
