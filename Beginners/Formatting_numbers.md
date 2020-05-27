## Formatting numbers

- If the numbers are converted to the string, they usually need to be reasonably formatted. The formatting of a number means the number is printed with a given number, made up of digits and decimals. The representation of a value can also be chosen. A closely related problem with this, however, is the localization of number formatting. For example, some languages use comma-separated zeros.

## Create the format.go file with the following content:
```
        package main

        import (
          "fmt"
        )

        var integer int64 = 32500
        var floatNum float64 = 22000.456

        func main() {

          // Common way how to print the decimal
          // number
          fmt.Printf("%d \n", integer)

          // Always show the sign
          fmt.Printf("%+d \n", integer)

          // Print in other base X -16, o-8, b -2, d - 10
          fmt.Printf("%X \n", integer)
          fmt.Printf("%#X \n", integer)

          // Padding with leading zeros
          fmt.Printf("%010d \n", integer)

          // Left padding with spaces
          fmt.Printf("% 10d \n", integer)

          // Right padding
          fmt.Printf("% -10d \n", integer)

          // Print floating
          // point number
          fmt.Printf("%f \n", floatNum)

          // Floating-point number
          // with limited precision = 5
          fmt.Printf("%.5f \n", floatNum)

          // Floating-point number
          // in scientific notation
          fmt.Printf("%e \n", floatNum)

          // Floating-point number
          // %e for large exponents
          // or %f otherwise
          fmt.Printf("%g \n", floatNum)

        }

```
output:
```
sangam:golang-daily sangam$ go run format.go
32500 
+32500 
7EF4 
0X7EF4 
0000032500 
     32500 
 32500     
22000.456000 
22000.45600 
2.200046e+04 
22000.456 

```

## Create the file localized.go with the following content:

```
        package main

        import (
          "golang.org/x/text/language"
          "golang.org/x/text/message"
        )

        const num = 100000.5678

        func main() {
          p := message.NewPrinter(language.English)
          p.Printf(" %.2f \n", num)

          p = message.NewPrinter(language.German)
          p.Printf(" %.2f \n", num)
        }

```
output:

```
sangam:golang-daily sangam$ go run localized.go
 100,000.57 
 100.000,57 
sangam:golang-daily sangam$ 

```
## How it works...

- The code example shows the most commonly used options for integers and floating-point numbers.
- Note:The formatting in Go is derived from C's printf function. The so-called verbs are used to define the formatting of a number. The verb, for example, could be %X, which in fact is a placeholder for the value.
- Besides the basic formatting, there are also rules in formatting that are related to the local manners. With formatting, according to the locale, the package golang.org/x/text/message could help. See the second code example in this recipe. This way, it is possible to localize the number formatting.

## There's more...

- For all formatting options, see the fmt package. The strconv package could also be useful in case you are looking to format numbers in a different base. The following recipe describes the possibility of number conversion, but as a side effect, the options of how to format numbers in a different base are presented
