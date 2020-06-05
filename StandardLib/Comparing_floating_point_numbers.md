## Comparing floating-point numbers

- Because of how floating-point numbers are represented, there can be inconsistencies while comparing two numbers that appear to be identical. Unlike integers, IEEE floating-point numbers are only approximated. The need to convert the numbers to a form the computer can store in binary leads to minor precision or round-off deviations. For example, a value of 1.3 could be represented as 1.29999999999. 
The comparison could be done with some tolerance. To compare numbers with arbitrary precision, the big package is here.

## Create the tolerance.go file with the following content:

```
        package main

        import (
          "fmt"
          "math"
        )

        const da = 0.29999999999999998889776975374843459576368331909180
        const db = 0.3

        func main() {

          daStr := fmt.Sprintf("%.10f", da)
          dbStr := fmt.Sprintf("%.10f", db)

          fmt.Printf("Strings %s = %s equals: %v \n", daStr,
                     dbStr, dbStr == daStr)
          fmt.Printf("Number equals: %v \n", db == da)

          // As the precision of float representation
          // is limited. For the float comparison it is
          // better to use comparison with some tolerance.
          fmt.Printf("Number equals with TOLERANCE: %v \n", 
                     equals(da, db))

        }

        const TOLERANCE = 1e-8
        // Equals compares the floating-point numbers
        // with tolerance 1e-8
        func equals(numA, numB float64) bool {
          delta := math.Abs(numA - numB)
          if delta < TOLERANCE {
            return true
          }
          return false
        }


```
output: 

```
sangam:golang-daily sangam$ go run tolerance.go
Strings 0.3000000000 = 0.3000000000 equals: true 
Number equals: false 
Number equals with TOLERANCE: true 
sangam:golang-daily sangam$ 

```
## Create the file big.go with the following content:

```
        package main

        import (
          "fmt"
          "math/big"
        )

        var da float64 = 0.299999992
        var db float64 = 0.299999991

        var prec uint = 32
        var prec2 uint = 16

        func main() {

          fmt.Printf("Comparing float64 with '==' equals: %v\n", da == db)

          daB := big.NewFloat(da).SetPrec(prec)
          dbB := big.NewFloat(db).SetPrec(prec)

          fmt.Printf("A: %v \n", daB)
          fmt.Printf("B: %v \n", dbB)
          fmt.Printf("Comparing big.Float with precision: %d : %v\n",
                     prec, daB.Cmp(dbB) == 0)

          daB = big.NewFloat(da).SetPrec(prec2)
          dbB = big.NewFloat(db).SetPrec(prec2)

          fmt.Printf("A: %v \n", daB)
          fmt.Printf("B: %v \n", dbB)
          fmt.Printf("Comparing big.Float with precision: %d : %v\n",
                     prec2, daB.Cmp(dbB) == 0)

        }


```

output:
```
sangam:golang-daily sangam$ go run big.go
Comparing float64 with '==' equals: false
A: 0.299999992 
B: 0.299999991 
Comparing big.Float with precision: 32 : false
A: 0.3 
B: 0.3 
Comparing big.Float with precision: 16 : true
sangam:golang-daily sangam$ 

```

## How it works...

- The first approach for the floating-point numbers comparison without the use of any built-in package (steps 1-5) requires the use of a so-called EPSILON constant. This is the value chosen to be a sufficient small delta (difference) between two numbers to consider the values as equal. The delta constant could be on the order of 1e-8, which is usually sufficient precision.

- The second option is more complex, but also more useful for further work with floating-point numbers. The package math/big offers the Float type that could be configured for a given precision. The advantage of this package is that the precision could be much higher than the precision of the float64 type. For illustrative purposes, the small precision values were used to show the rounding and comparison in the given precision.

- Note that the da and db numbers are equal when using the precision of 16-bits and not equal when using the precision of 32-bits. The maximal configurable precision can be obtained from the big.MaxPrec constant.
