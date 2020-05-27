## Taking logarithms

- Logarithms are used in scientific applications as well as in data visualizations and measurements. 
The built-in math package contains the commonly used bases of the logarithm. Using these, you are able to get all bases.

## Create the log.go file with the following content:
```
package main

import (
	"fmt"
	"math"
)

func main() {

	ln := math.Log(math.E)
	fmt.Printf("Ln(E) = %.4f\n", ln)

	log10 := math.Log10(-100)
	fmt.Printf("Log10(10) = %.4f\n", log10)

	log2 := math.Log2(2)
	fmt.Printf("Log2(2) = %.4f\n", log2)

	log_3_6 := Log(3, 6)
	fmt.Printf("Log3(6) = %.4f\n", log_3_6)

}

// Log computes the logarithm of
// base > 1 and x greater 0
func Log(base, x float64) float64 {
	return math.Log(x) / math.Log(base)
}


```
output:
```
sangam:golang-daily sangam$ go run log.go 
Ln(E) = 1.0000
Log10(10) = NaN
Log2(2) = 1.0000
Log3(6) = 1.6309
```
## How it works...
- The standard package, math, contains functions for all commonly used logarithms,
and so you can easily get binary, decimal, and natural logarithms. See the Log function which counts any 
logarithm of y with base x through the helper-defined formula:
![img](https://raw.githubusercontent.com/collabnix/gopherlabs/master/img/log.jpg)

- The internal implementation of the logarithm in standard lib is naturally based on approximation.
This function can be seen in the $GOROOT/src/math/log.go file.

