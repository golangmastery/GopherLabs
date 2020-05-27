## Floating-point arithmetics

- As described in previous recipes, the representation of the floating-point numbers also complicates the arithmetic. For general purposes, the operations on the built-in float64 are sufficient. In case more precision is needed, the math/big package comes into play. This recipe will show you how to handle this.

```
        package main

        import (
          "fmt"
          "math/big"
        )

        const ( 
            PI = `3.1415926535897932384626433832795028841971693
                    993751058209749445923078164062862089986280348253
                    421170679821480865132823066470938446095505822317
                    253594081284811174502841027019385211055596446229
                    4895493038196`
         diameter = 3.0
         precision = 400
         )

        func main() {

          pi, _ := new(big.Float).SetPrec(precision).SetString(PI)
          d := new(big.Float).SetPrec(precision).SetFloat64(diameter)

          circumference := new(big.Float).Mul(pi, d)

          pi64, _ := pi.Float64()
          fmt.Printf("Circumference big.Float = %.400f\n",
                     circumference)
          fmt.Printf("Circumference float64 = %.400f\n", pi64*diameter)

          sum := new(big.Float).Add(pi, pi)
          fmt.Printf("Sum = %.400f\n", sum)

          diff := new(big.Float).Sub(pi, pi)
          fmt.Printf("Diff = %.400f\n", diff)

          quo := new(big.Float).Quo(pi, pi)
          fmt.Printf("Quocient = %.400f\n", quo)

        }

```
output: 
```
sangam:golang-daily sangam$ go run main.go
Circumference big.Float = 9.4247779607693797153879301498385086525915081981253174629248337769234492188586269958841044760263512039
Circumference float64   = 9.4247779607693793479938904056325554847717285156250000000000000000000000000000000000000000000000000000
Sum = 6.2831853071795864769252867665590057683943387987502116419498891846156328125724179972560696506842341360
Diff = 0.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
Quocient = 1.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
```
## How it works...

- The big package provides support for the arithmetic of floating-point numbers with high precision. The previous example illustrates the basic operations over the numbers. Note that the code compares the operation with the float64 type and the big.Float type.

- By working with numbers with a high precision, it is crucial to use the big.Float type. When big.Float is converted back to the built-in float64 type, high precision is lost.  


The big package contains more operations of the Float type. See the documentation (https://golang.org/pkg/math/big/#Float) of this package for more details.
