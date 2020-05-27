# Writing the file

- Writing a file is an essential task for every programmer; 
Go supports multiple ways on how you can do this. This recipe will show a few of them.

## Create the writefile.go file with the following content:
```
package main

import (
	"io"
	"os"
	"strings"
)

func main() {

	f, err := os.Create("sample.file")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	_, err = f.WriteString("Go is awesome!\n")
	if err != nil {
		panic(err)
	}

	_, err = io.Copy(f, strings.NewReader("Yeah! Go is great.\n"))
	if err != nil {
		panic(err)
	}
}



```
output:
```
sangam:golang-daily sangam$  go run writefile.go
```
## Check the content of the created sample.file:
```
sangam:golang-daily sangam$ cat sample.file 
Go is awesome!
Yeah! Go is great.
sangam:golang-daily sangam$ 

```
## How it works...

- The os.File type implements the Writer interface, so writing to the file could be done by any option that uses the Writer interface. The preceding example uses the  WriteString method of the os.File type. 
The io.WriteString method can also be used in general.

