# Creating a program interface with the flag package

- The previous recipe describes how to access the program arguments by a very generic approach.

- This recipe will provide a way of defining an interface via the program flags. This approach dominates systems based on GNU/Linux, BSD, and macOS.  The example of the program call could be ls -l which will, on *NIX systems, list the files in a current directory. 

- The Go package for flag handling does not support flag combining like ls -ll, where there are multiple flags after a single dash. Each flag must be separate. The Go flag package also does not differentiate between long options and short ones. Finally, -flag and --flag are equivalent.

Create the main.go file with the following content:

```
package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
)

// Custom type need to implement
// flag.Value interface to be able to
// use it in flag.Var function.
type ArrayValue []string

func (s *ArrayValue) String() string {
	return fmt.Sprintf("%v", *s)
}

func (a *ArrayValue) Set(s string) error {
	*a = strings.Split(s, ",")
	return nil
}

func main() {

	// Extracting flag values with methods returning pointers
	retry := flag.Int("retry", -1, "Defines max retry count")

	// Read the flag using the XXXVar function.
	// In this case the variable must be defined
	// prior to the flag.
	var logPrefix string
	flag.StringVar(&logPrefix, "prefix", "", "Logger prefix")

	var arr ArrayValue
	flag.Var(&arr, "array", "Input array to iterate through.")

	// Execute the flag.Parse function, to
	// read the flags to defined variables.
	// Without this call the flag
	// variables remain empty.
	flag.Parse()

	// Sample logic not related to flags
	logger := log.New(os.Stdout, logPrefix, log.Ldate)

	retryCount := 0
	for retryCount < *retry {
		logger.Println("Retrying connection")
		logger.Printf("Sending array %v\n", arr)
		retryCount++
	}
}



```
output 

```
Biradars-MacBook-Air-4:golang-daily sangam$ go build -o util
Biradars-MacBook-Air-4:golang-daily sangam$ ./util -retry 2 -prefix=example -array=1,2
example2019/11/30 Retrying connection
example2019/11/30 Sending array [1 2]
example2019/11/30 Retrying connection
example2019/11/30 Sending array [1 2]
Biradars-MacBook-Air-4:golang-daily sangam$ 

```
# How it works…

- For the flag definition in code, the flag package defines two types of functions.

- The first type is the simple name of the flag type such as Int. This function will return the pointer to the integer variable where the value of the parsed flag is.

- The XXXVar functions are the second type. These provide the same functionality, but you need to provide the pointer to the variable. The parsed flag value will be stored in the given variable.

- The Go library also supports a custom flag type. The custom type must implement the Value interface from the flag package.

- As an example, let's say the flag retry defines the retry limit for reconnecting to the endpoint, the prefix flag defines the prefix of each row in a log, and the array is the array flag that will be send as an payload to server. The program call from the Terminal will look like ./util -retry 2 -prefix=example array=1,2.

- The important part of the preceding code is the Parse() function which parses the defined flags from Args[1:]. The function must be called after all flags are defined and before the values are accessed.

- The preceding code shows how to parse some data types from the command-line flags. Analogously, the other built-in types are parsed. 

- The last flag, array, demonstrates the definition of the custom type flag. Note that the ArrayType implements the Value interface from the flag package.

# There's more…

- The flag package contains more functions to design the interface with flags. It is worth reading the documentation for FlagSet.

- By defining the new FlagSet, the arguments could be parsed by calling the myFlagset.Parse(os.Args[2:]). This way you can have flag subsets based on, for example, the first flag.
