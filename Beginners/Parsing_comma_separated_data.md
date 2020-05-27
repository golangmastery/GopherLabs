## Parsing comma-separated data

- There are multiple table data formats. CSV (comma-separated values) is one of the most basic formats largely used for data transport and export. There is no standard that defines CSV, but the format itself is described in RFC 4180.

- This recipe introduces how to parse CSV-formatted data comfortably.

Create a file named data.csv with the following content:
```
"Name","Surname","Age"
# this is comment in data
"sangam","biradar",24
arjun,singh,21

```
Create the main.go file with the following content:
```

        package main

        import (
          "encoding/csv"
          "fmt"
          "os"
        )

        func main() {

          file, err := os.Open("data.csv")
          if err != nil {
            panic(err)
          }
          defer file.Close()

          reader := csv.NewReader(file)
          reader.FieldsPerRecord = 3
          reader.Comment = '#'

          for {
            record, e := reader.Read()
            if e != nil {
              fmt.Println(e)
              break
            }
            fmt.Println(record)
          }
        }

```

output:

```
sangam:golang-daily sangam$ go run main.go
[Name Surname Age]
[sangam biradar 24]
[arjun singh 21]
EOF
sangam:golang-daily sangam$ 

```
Create a file named data_uncommon.csv with the following content:
```
Name;Surname;Age
"sangam";biradar;24
"arjun";singh;21


```
Create a file named main.go with the following content:
```
package main

import (
	"encoding/csv"
	"fmt"
	"os"
)

func main() {

	file, err := os.Open("data_uncommon.csv")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	reader := csv.NewReader(file)
	reader.Comma = ';'

	for {
		record, e := reader.Read()
		if e != nil {
			fmt.Println(e)
			break
		}
		fmt.Println(record)
	}
}


```
output:
```
sangam:golang-daily sangam$ go run main.go
[Name Surname Age]
[sangam biradar 24]
[arjun singh 21]
EOF
sangam:golang-daily sangam$ 
```

## How it works...

- Instead of simply scanning the input line by line and using strings.Split and other methods to parse the CSV format, Go offers a better way. The NewReader function in the encoding/csv package returns the Reader structure, which provides the API to read the CSV file. The Reader struct keeps variables to configure the read parameters, according to your needs.

- The FieldsPerRecord parameter of Reader is a significant setting. This way the cell count per row could be validated. By default, when set to 0, it is set to the number of records in a first line. If a positive value is set, the number of records must match. If a negative value is set, there is no cell count validation.

- Another interesting configuration is the Comment parameter, which allows you to define the comment characters in the parsed data. In the example, a whole line is ignored this way.
