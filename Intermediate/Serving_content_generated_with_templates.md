## Serving content generated with templates

- For some purposes, it is not necessary to create highly dynamic web UI with all the JavaScript, and the static content with generated content could be sufficient. The Go standard library provides a way of constructing dynamically generated content. 
lead into the Go standard library templating.


## Create the file template.tpl with the following content:

```
        <html>
          <body>
            Hi, I'm HTML body for index.html!
          </body>
        </html>

```
## Create the file dynamic.go with the following content:
```
package main

import "net/http"
import "html/template"

func main() {
	tpl, err := template.ParseFiles("template.tpl")
	if err != nil {
		panic(err)
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		err := tpl.Execute(w, "John Doe")
		if err != nil {
			panic(err)
		}
	})
	http.ListenAndServe(":8085", nil)
}
```
output:
```
sangam:golang-daily sangam$ go run main.go
sangam:golang-daily sangam$ curl http://localhost:8085
   <html>
       <body>
         Hi, I'm HTML body for index.html!
      </body>
   </html>


```

## How it works...

- The Go standard library also contains the package for templating the content. 
The packages html/template and text/template provide the functions to parse the templates and use them to create the output. 
The parsing is done with the ParseXXX functions or the methods of the newly-created Template struct pointer. 
The preceding example uses the ParseFiles function of the html/template package.

- The templates themselves are text-based documents or pieces of text which contain dynamic variables.
The use of the template is based on merging the template text with the structure that contains the values for the variables present in the template. 
For merging the template with such structures, the Execute and ExecuteTemplate methods are there. 
Note that these  consume the writer interface, where the output is written; the ResponseWriter is used in this case
