## Converting between degrees and radians

- The trigonometric operations and geometric manipulation are usually done in radians; it is always useful to be able to convert these into degrees and vice versa. 
  show you some tips on how to handle the conversion between these units.

## Create the radians.go file with the following content:
```
package main

import (
	"fmt"
	"math"
)

type Radian float64

func (rad Radian) ToDegrees() Degree {
	return Degree(float64(rad) * (180.0 / math.Pi))
}

func (rad Radian) Float64() float64 {
	return float64(rad)
}

type Degree float64

func (deg Degree) ToRadians() Radian {
	return Radian(float64(deg) * (math.Pi / 180.0))
}

func (deg Degree) Float64() float64 {
	return float64(deg)
}

func main() {

	val := radiansToDegrees(1)
	fmt.Printf("One radian is : %.4f degrees\n", val)

	val2 := degreesToRadians(val)
	fmt.Printf("%.4f degrees is %.4f rad\n", val, val2)

	// Conversion as part
	// of type methods
	val = Radian(1).ToDegrees().Float64()
	fmt.Printf("Degrees: %.4f degrees\n", val)

	val = Degree(val).ToRadians().Float64()
	fmt.Printf("Rad: %.4f radians\n", val)
}

func degreesToRadians(deg float64) float64 {
	return deg * (math.Pi / 180.0)
}

func radiansToDegrees(rad float64) float64 {
	return rad * (180.0 / math.Pi)
}


```
output:
```
sangam:golang-daily sangam$ go run radians.go
One radian is : 57.2958 degrees
57.2958 degrees is 1.0000 rad
Degrees: 57.2958 degrees
Rad: 1.0000 radians

```

## How it works...

- The Go standard library does not contain any package with a function converting radians to degrees and vice versa. But at least the Pi constant is a part of the math package, so the conversion could be done as shown in the sample code.

- The preceding code also presents the approach of defining the custom type with additional methods. These are simplifying the conversion of values by handy API.
