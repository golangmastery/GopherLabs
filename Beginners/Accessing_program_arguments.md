# Accessing program arguments

The most simple way to parameterize the program run is to use the command-line arguments as program parameters. 

Simply, the parameterized program call could look like this: ./parsecsv user.csv role.csv. In this case, parsecsv is the name of the executed binary and user.csv and role.csv are the arguments, that modify the program call (in this case it refers to files to be parsed).

- How to do it...

Create the main.go file with the following content:
```
package main

import (
	"fmt"
	"os"
)

func main() {

	args := os.Args

	// This call will print
	// all command line arguments.
	fmt.Println(args)

	// The first argument, zero item from slice,
	// is the name of the called binary.
	programName := args[0]
	fmt.Printf("The binary name is: %s \n", programName)

	// The rest of the arguments could be obtained
	// by omitting the first argument.
	otherArgs := args[1:]
	fmt.Println(otherArgs)

	for idx, arg := range otherArgs {
		fmt.Printf("Arg %d = %s \n", idx, arg)
	}
}


```

output 

```
Biradars-MacBook-Air-4:golang-daily sangam$ go build -o test
Biradars-MacBook-Air-4:golang-daily sangam$ ./test arg1 arg2
[./test arg1 arg2]
The binary name is: ./test 
[arg1 arg2]
Arg 0 = arg1 
Arg 1 = arg2 
Biradars-MacBook-Air-4:golang-daily sangam$ 

```
- How it works...

- The Go standard library offers a few ways to access the arguments of the program call. The most generic way is to access the arguments by the Args variable from the OS package.

- This way you can get all the arguments from the command line in a string slice. The advantage of this approach is that the number of arguments is dynamic and this way you can, for example, pass the names of the files to be processed by the program.

- The preceding example just echoes all the arguments that are passed to the program. Finally, let's say the binary is called test and the program run is executed by the Terminal command ./test arg1 arg2.

- In detail, the os.Args[0] will return ./test. The os.Args[1:] returns the rest of the arguments without the binary name. In the real world, it is better to not rely on the number of arguments passed to the program, but always check the length of the argument array. Otherwise, naturally, if the argument on a given index is not within the range, the program panics.
There's more…

- If the arguments are defined as flags, -flag value, additional logic is needed to assign the value to the flag. In this case, there is a better way to parse these by using the flag package. This approach is part of the next recipe
