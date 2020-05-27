# Creating files and directories

- few general ways you can create files and directories in code.

## Create the create.go file with the following content:

```
package main

import (
	"os"
)

func main() {

	f, err := os.Create("created.file")
	if err != nil {
		panic(err)
	}
	f.Close()

	f, err = os.OpenFile("created.byopen", os.O_CREATE|os.O_APPEND,
		os.ModePerm)
	if err != nil {
		panic(err)
	}
	f.Close()

	err = os.Mkdir("createdDir", 0777)
	if err != nil {
		panic(err)
	}

	err = os.MkdirAll("sampleDir/path1/path2", 0777)
	if err != nil {
		panic(err)
	}

}



```

output: 

```
sangam:golang-daily sangam$ create.go
sangam:golang-daily sangam$ tree
.
├── binary
├── config.json
├── content.dat
├── created.byopen
├── created.file
├── createdDir
├── data.csv
├── data.xml
├── data.zip
├── example.txt
├── flatfile.txt
├── main.go
├── sample.file
├── sample.txt
├── sampleDir
│   └── path1
│       └── path2


```
## How it works...

- The previous example represents four ways you can create a file or directory. The os.Create function is the simplest way to create the file. By using this function, you will create the file with permissions such as 0666.

- If you need to create the file with any other configuration of permissions, then the OpenFile function of the os package is the one to be used.

- The directories can be created by using the Mkdir function of the os package. This way, a directory with given permissions is created. The second option is to use the MkdirAll function. This function also creates the directory, but if the given path contains non-exiting directories,
then all directories in the path are created (it works the same as the -p option of Unix's mkdir utility).
