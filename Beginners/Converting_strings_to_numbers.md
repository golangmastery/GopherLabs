## Converting strings to numbers

Create the main.go file with the following content:

```
package main

import (
	"fmt"
	"strconv"
)

const bin = "00001"
const hex = "2f"
const intString = "12"
const floatString = "12.3"

func main() {

	// Decimals
	res, err := strconv.Atoi(intString)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Parsed integer: %d\n", res)

	// Parsing hexadecimals
	res64, err := strconv.ParseInt(hex, 16, 32)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Parsed hexadecima: %d\n", res64)

	// Parsing binary values
	resBin, err := strconv.ParseInt(bin, 2, 32)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Parsed bin: %d\n", resBin)

	// Parsing floating-points
	resFloat, err := strconv.ParseFloat(floatString, 32)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Parsed float: %.5f\n", resFloat)

}




```

output: 
```
sangam:golang-daily sangam$ go run main.go
Parsed integer: 12
Parsed hexadecima: 47
Parsed bin: 1
Parsed float: 12.30000
sangam:golang-daily sangam$ 

```

## How it works...

- The dominant function in the preceding sample code is the ParseInt function of package strconv. The function is called with three arguments: input, the base of input, and bit size. The base determines how the number is parsed. Note that the hexadecimal has the base (second argument) of 16 and the binary has the base of 2. The function Atoi of package strconv is, in fact, the ParseInt function with the base of 10.

- The  ParseFloat function converts the string to a floating-point number. The second argument is the precision of bitSize. bitSize = 64 will result in float64. bitSize = 32 will result in float64, but it is convertible to float32 without changing its value. 
