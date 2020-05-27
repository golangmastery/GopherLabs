## Operating complex numbers

- Complex numbers are usually used for scientific applications and calculations. Go implements complex numbers as the primitive type. 
- The specific operations on complex numbers are part of the math/cmplx package.

## Create the complex.go file with the following content:

```

        package main

        import (
          "fmt"
          "math/cmplx"
        )

        func main() {

          // complex numbers are
          // defined as real and imaginary
          // part defined by float64
          a := complex(2, 3)

          fmt.Printf("Real part: %f \n", real(a))
          fmt.Printf("Complex part: %f \n", imag(a))

          b := complex(6, 4)

          // All common
          // operators are useful
          c := a - b
          fmt.Printf("Difference : %v\n", c)
          c = a + b
          fmt.Printf("Sum : %v\n", c)
          c = a * b
          fmt.Printf("Product : %v\n", c)
          c = a / b
          fmt.Printf("Product : %v\n", c)

          conjugate := cmplx.Conj(a)
          fmt.Println("Complex number a's conjugate : ", conjugate)

          cos := cmplx.Cos(b)
          fmt.Println("Cosine of b : ", cos)

        }

```

output:
```
sangam:golang-daily sangam$ go run complex.go 
Real part: 2.000000 
Complex part: 3.000000 
Difference : (-4-1i)
Sum : (8+7i)
Product : (0+26i)
Product : (0.46153846153846156+0.19230769230769232i)
Complex number a's conjugate :  (2-3i)
Cosine of b :  (26.220553750072888+7.625225809442885i)


```

## How it works...

- The basic operators are implemented for the primitive type complex. The other operations on complex numbers are provided by the math/cmplx package. In case high precision operations are needed, there is no big implementation. 

- On the other hand, the complex number could be implemented as real, and the imaginary part expressed by the big.Float type.
