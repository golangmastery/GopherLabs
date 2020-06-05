## Aligning text with tabwriter

- In certain cases, the output (usually data output) is done via tabbed text, which is formatted in well-arranged cells. This format could be achieved with the text/tabwriter package. The package provides the Writer filter, which transforms the text with the tab characters into properly formatted output text.

## Create the main.go file with the following content:



```
        package main

        import (
          "fmt"
          "os"
          "text/tabwriter"
        )

        func main() {

          w := tabwriter.NewWriter(os.Stdout, 15, 0, 1, ' ',
                                   tabwriter.AlignRight)
          fmt.Fprintln(w, "username\tfirstname\tlastname\t")
          fmt.Fprintln(w, "sohlich\tRadomir\tSohlich\t")
          fmt.Fprintln(w, "novak\tJohn\tSmith\t")
          w.Flush()

        }



```


output: 

```
sangam:golang-daily sangam$ go run main.go
       username      firstname       lastname
        sohlich        Radomir        Sohlich
          novak           John          Smith
sangam:golang-daily sangam$ 


```

## How it works...

- The NewWriter function call creates the Writer filter with configured parameters. All data written by this Writer is formatted according to the parameters. os.Stdout is used here for demonstration purposes.

- The text/tabwriter package also provides a few more configuration options, such as the flag parameter.  The most useful is tabwriter.AlignRight, which configures the writer to align the content to the right in each column.
