## Rounding floating-point numbers

- The rounding of a floating-point number to an integer or to a particular precision has to be done properly. The most common error is to cast the floating-point type float64 to an integer type and consider it as well-handled.

- An example could be casting the number 3.9999 to an integer and expect it to become an integer of value 4. The real result would be 3. At the time of writing this book, the current version of Go (1.9.2) does not contain the Round function. However, in version 1.10, 
the Round function was already implemented in the math package.

# Create the round.go file with the following content:

 ```
   package main

        import (
          "fmt"
          "math"
        )

        var valA float64 = 3.55554444

        func main() {

          // Bad assumption on rounding
          // the number by casting it to
          // integer.
          intVal := int(valA)
          fmt.Printf("Bad rounding by casting to int: %v\n", intVal)

          fRound := Round(valA)
          fmt.Printf("Rounding by custom function: %v\n", fRound)

        }

        // Round returns the nearest integer.
        func Round(x float64) float64 {
          t := math.Trunc(x)
          if math.Abs(x-t) >= 0.5 {
            return t + math.Copysign(1, x)
          }
          return t
        }


```
![Go playground](https://play.golang.org/p/j-f8JD-kRDY)

```
Bad rounding by casting to int: 3
Rounding by custom function: 4
```
## How it works...

- Casting the float to integer actually just truncates the float value. Let's say the value 2 is represented as 1.999999; in this case, the output would be 1, which is not what you expected.

- The proper way of rounding the float number is to use the function that would also consider the decimal part. The commonly used method of rounding is to half away from zero (also known as commercial rounding). Put simply, if the number contains the absolute value of the decimal part which is greater or equal to 0.5, the number is rounded up, otherwise, it is rounded down.

- In the function Round, the function Trunc of package math truncates the decimal part of the number. Then, the decimal part of the number is extracted. If the value exceeds the limit of 0.5 than the value of 1 with the same sign as the integer value is added.
