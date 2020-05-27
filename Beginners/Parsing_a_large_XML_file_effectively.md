# Parsing a large XML file effectively

- XML is a very common format for data exchange. The Go library contains support for parsing XML files the same way as the JSON. Usually,
the struct which corresponds to the XML scheme is used and with this help, the XML content is parsed at once. The problem is when the XML file is too large to fit into memory and so you need to parse the file in chunks. 
This recipe will reveal how to handle a large XML file and parse the required information.

## Create the data.xml file with the following XML content:
```

        <?xml version="1.0"?>
        <catalog>
          <book id="bk101">
            <author>Gambardella, Matthew</author>
            <title>XML Developer's Guide</title>
            <genre>Computer</genre>
            <price>44.95</price>
            <publish_date>2000-10-01</publish_date>
            <description>An in-depth look at creating applications 
             with XML.</description>
          </book>
          <book id="bk112">
            <author>Galos, Mike</author>
            <title>Visual Studio 7: A Comprehensive Guide</title>
            <genre>Computer</genre>
            <price>49.95</price>
            <publish_date>2001-04-16</publish_date>
            <description>Microsoft Visual Studio 7 is explored
             in depth, looking at how Visual Basic, Visual C++, C#,
             and ASP+ are integrated into a comprehensive development
             environment.</description>
          </book>
        </catalog>

```
## Create the xml.go file with the following content:
```

        package main

        import (
          "encoding/xml"
          "fmt"
          "os"
        )

        type Book struct {
          Title string `xml:"title"`
          Author string `xml:"author"`
        }

        func main() {

          f, err := os.Open("data.xml")
          if err != nil {
            panic(err)
          }
          defer f.Close()
          decoder := xml.NewDecoder(f)

          // Read the book one by one
          books := make([]Book, 0)
          for {
            tok, _ := decoder.Token()
            if tok == nil {
              break
            }
            switch tp := tok.(type) {
              case xml.StartElement:
                if tp.Name.Local == "book" {
                  // Decode the element to struct
                  var b Book
                  decoder.DecodeElement(&b, &tp)
                  books = append(books, b)
                }
            }
          }
          fmt.Println(books)
        }


```
output: 

```
sangam:golang-daily sangam$ go run xml.go 
[{XML Developer's Guide Gambardella, Matthew} {Visual Studio 7: A Comprehensive Guide Galos, Mike}]
sangam:golang-daily sangam$ 

```
How it works...

- With the NewDecoder function of the xml package, the Decoder for the XML content is created. 

- By calling the Token method on the Decoder, the xml.Token is received. The xml.Token is the interface which holds 
the token type. The behavior of the code can be defined, based on the type. The sample code tests 
if the parsed xml.StartElement is one of the book elements. 
- Then it partially parses the data into a Book structure. 
This way, the position of the pointer in the underlying Reader in the Decoder is shifted by the struct data, and 
the parsing can continue.
