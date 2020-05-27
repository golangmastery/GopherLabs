# CRUD web forms

To start a basic HTML page with the Go net/http package, the web forms example is as follows (webforms.go). 
This has a welcome greeting in main.html:

```
package main
// importing fmt, database/sql, net/http, text/template package
import (
 "net/http"
 "text/template"
 "log")
// Home method renders the main.html
func Home(writer http.ResponseWriter, reader *http.Request) {
 var template_html *template.Template
 template_html = template.Must(template.ParseFiles("main.html"))
 template_html.Execute(writer,nil)
}
// main method
func main() {
 log.Println("Server started on: http://localhost:8000")
 http.HandleFunc("/", Home)
 http.ListenAndServe(":8000", nil)
}

```
The code for main.html is as follows:

```
<html>
    <body>
        <p> Welcome to Web Forms</p>
    </body>
</html>

```

Run the following commands:

```
go run webforms.go

```

open localhost 8080 in browser 


The CRM application is built with web forms as an example to demonstrate CRUD operations. We can use the database operations we built in the previous section. In the following code, the crm database operations are presented. The crm database operations consist of CRUD methods such as CREATE, READ, UPDATE, and DELETE customer operations. The GetConnection 
method retrieves the database connection for performing the database operations (crm_database_operations.go):

```

//main package has examples shown

package main
// importing fmt,database/sql, net/http, text/template package
import (
 "database/sql"
 _ "github.com/go-sql-driver/mysql"
)
// Customer Class
type Customer struct {
 CustomerId int
 CustomerName string
 SSN string
}
//  GetConnection method  which returns sql.DB
func GetConnection() (database *sql.DB) {
 databaseDriver := "mysql"
 databaseUser := "newuser"
 databasePass := "newuser"
 databaseName := “crm"
 database, error := sql.Open(databaseDriver, databaseUser+”:"+databasePass+"@/"+databaseName)
 if error != nil {
 panic(error.Error())
 }
 return database
}


```

As shown in the following code, the GetCustomerById method takes the customerId parameter to look up in the customer database. 
The GetCustomerById method returns the customer object:


```

//GetCustomerById with parameter customerId returns Customer
func GetCustomerById(customerId int) Customer {
 var database *sql.DB
 database = GetConnection()
 var error error
 var rows *sql.Rows
 rows, error = database.Query("SELECT * FROM Customer WHERE CustomerId=?",customerId)
 if error != nil {
 panic(error.Error())
 }
 var customer Customer
 customer = Customer{}
 for rows.Next() {
 var customerId int
 var customerName string
 var SSN string
 error = rows.Scan(&customerId, &customerName, &SSN)
 if error != nil {
 panic(error.Error())
 }
 customer.CustomerId = customerId
 customer.CustomerName = customerName
 customer.SSN = SSN
 }
 
 ```
 
 Now that we have covered CRUD web forms, let's move on to defer and panic in the next section.

## The defer and panic statements

The defer statement defers the execution of the function until the surrounding function returns. The panic function stops the current flow and control. Deferred functions are executed normally after the panic call.
In the following code example, the defer call gets executed even when the panic call is invoked:

```

 defer database.Close()
 return customer
}
// GetCustomers method returns Customer Array
func GetCustomers() []Customer {
 var database *sql.DB
 database = GetConnection()
 var error error
 var rows *sql.Rows
 rows, error = database.Query("SELECT * FROM Customer ORDER BY Customerid DESC")
 if error != nil {
 panic(error.Error())
 }
 var customer Customer
 customer = Customer{}
 var customers []Customer
 customers= []Customer{}
 for rows.Next() {
 var customerId int
 var customerName string
 var ssn string
 error = rows.Scan(&customerId, &customerName, &ssn)
 if error != nil {
 panic(error.Error())
 }
 customer.CustomerId = customerId
 customer.CustomerName = customerName
 customer.SSN = ssn
 customers = append(customers, customer)
 }
 defer database.Close()
 return customers
}



```

Let's take a look at the InsertCustomer, UpdateCustomer, and DeleteCustomer methods in the following sections.
The InsertCustomer method

In the following code, the InsertCustomer method takes customer as a parameter to 
execute the SQL statement for inserting into the CUSTOMER table:

```

// InsertCustomer method with parameter customer
func InsertCustomer(customer Customer) {
     var database *sql.DB
     database= GetConnection()
     var error error
      var insert *sql.Stmt
     insert,error = database.Prepare("INSERT INTO CUSTOMER(CustomerName,SSN) VALUES(?,?)")
          if error != nil {
              panic(error.Error())
         }
     insert.Exec(customer.CustomerName,customer.SSN)
      defer database.Close()
}


```

The UpdateCustomer method

The UpdateCustomer method prepares the UPDATE statement by passing the CustomerName and SSN from the customer object; 
this is shown in the following code:

```

// Update Customer method with parameter customer
func UpdateCustomer(customer Customer) {
     var database *sql.DB
     database= GetConnection()
     var error error
      var update *sql.Stmt
      update,error = database.Prepare("UPDATE CUSTOMER SET CustomerName=?, SSN=? WHERE CustomerId=?")
          if error != nil {
              panic(error.Error())
          }
          update.Exec(customer.CustomerName,customer.SSN,customer.CustomerId)
     defer database.Close()
}



```
The DeleteCustomer method

The DeleteCustomer method deletes the customer that's passed by executing the DELETE statement
```
// Delete Customer method with parameter customer
func DeleteCustomer(customer Customer) {
     var database *sql.DB
     database= GetConnection()
      var error error
      var delete *sql.Stmt
      delete,error = database.Prepare("DELETE FROM Customer WHERE Customerid=?")
          if error != nil {
              panic(error.Error())
          }
          delete.Exec(customer.CustomerId)
     defer database.Close()
}


```

CRM web application

The CRM web application is shown as follows, with various web paths handled. 
The CRM application code is shown in the following code. The Home function executes the
Home template with the writer parameter and the customers array (crm_app.go):

```


//main package has examples shown
package main

// importing fmt,database/sql, net/http, text/template package
import (
    "fmt"
    "net/http"
    "text/template"
    "log"
)


var template_html = template.Must(template.ParseGlob("templates/*"))

// Home - execute Template
func Home(writer http.ResponseWriter, request *http.Request) {
    var customers []Customer
    customers = GetCustomers()
    log.Println(customers)
    template_html.ExecuteTemplate(writer,"Home",customers)

}


```

Let's take a look at the Create, Insert, Alter, Update, and Delete functions, as well as the main method in the following sections.
The Create function

As shown in the following code, the Create function takes the writer and request parameters to render the Create template:

```


// Create - execute Template
func Create(writer http.ResponseWriter, request *http.Request) {

    template_html.ExecuteTemplate(writer,"Create",nil)
}

```
The Insert function

The Insert function invokes the GetCustomers method to get an array of customers and renders the Home template with the writer and
customers arrays as parameters by invoking the ExecuteTemplate method. This is shown in the following code:

```


// Insert - execute template
func Insert(writer http.ResponseWriter, request *http.Request) {

    var customer Customer
    customer.CustomerName = request.FormValue("customername")
    customer.SSN = request.FormValue("ssn")
    InsertCustomer(customer)
    var customers []Customer
    customers = GetCustomers()
    template_html.ExecuteTemplate(writer,"Home",customers)

}

```

The Alter function

The following code shows how the Alter function renders the Home template by invoking the 
ExecuteTemplate method with the writer and customers arrays as parameters:

```
// Alter - execute template
func Alter(writer http.ResponseWriter, request *http.Request) {

    var customer Customer
    var customerId int
    var customerIdStr string
    customerIdStr = request.FormValue("id")
    fmt.Sscanf(customerIdStr, "%d", &customerId)
    customer.CustomerId = customerId
    customer.CustomerName = request.FormValue("customername")
    customer.SSN = request.FormValue("ssn")
    UpdateCustomer(customer)
    var customers []Customer
    customers = GetCustomers()
    template_html.ExecuteTemplate(writer,"Home",customers)

}






```

The Update function


The Update function invokes the ExecuteTemplate method with writer and customer looked up by id. 
The ExecuteTemplate method renders the UPDATE template:


```
// Update - execute template
func Update(writer http.ResponseWriter, request *http.Request) {

  var customerId int
  var customerIdStr string
  customerIdStr = request.FormValue("id")
  fmt.Sscanf(customerIdStr, "%d", &customerId)
  var customer Customer
  customer = GetCustomerById(customerId)

    template_html.ExecuteTemplate(writer,"Update",customer)

}


```

The Delete function

The Delete method renders the Home template after deleting the customer that's found by the GetCustomerById method. 
The View method renders the View template after finding the customer by invoking the GetCustomerById method:


```
// Delete - execute Template
func Delete(writer http.ResponseWriter, request *http.Request) {
  var customerId int
  var customerIdStr string
  customerIdStr = request.FormValue("id")
  fmt.Sscanf(customerIdStr, "%d", &customerId)
  var customer Customer
  customer = GetCustomerById(customerId)
   DeleteCustomer(customer)
   var customers []Customer
   customers = GetCustomers()
  template_html.ExecuteTemplate(writer,"Home",customers)

}
// View - execute Template
func View(writer http.ResponseWriter, request *http.Request) {
    var customerId int
    var customerIdStr string
    customerIdStr = request.FormValue("id")
    fmt.Sscanf(customerIdStr, "%d", &customerId)
    var customer Customer
    customer = GetCustomerById(customerId)
    fmt.Println(customer)
    var customers []Customer
    customers= []Customer{customer}
    customers.append(customer)
    template_html.ExecuteTemplate(writer,"View",customers)

}


```
The main method

The main method handles the Home, Alter, Create, Update, View, Insert, and Delete functions with different aliases for lookup and renders the templates appropriately.
HttpServer listens to port 8000 and waits for template alias invocation:

```
// main method
func main() {
    log.Println("Server started on: http://localhost:8000")
    http.HandleFunc("/", Home)
    http.HandleFunc("/alter", Alter)
    http.HandleFunc("/create", Create)
    http.HandleFunc("/update", Update)
    http.HandleFunc("/view", View)
    http.HandleFunc("/insert", Insert)
    http.HandleFunc("/delete", Delete)
    http.ListenAndServe(":8000", nil)
}

```

Let's take a look at the Header, Footer, Menu, Create, Update, and View templates in the following sections.

# The Header template

The Header template has the HTML head and body defined in the code snippet, as follows. 
The TITLE tag of the web page is set to CRM and the web page has Customer Management – CRM as content (Header.tmpl):

```
{{ define "Header" }}
<!DOCTYPE html>
<html>
 <head>
 <title>CRM</title>
 <meta charset="UTF-8" />
 </head>
 <body>
 <h1>Customer Management – CRM</h1>
{{ end }}


```
## The Footer template

The Footer template has the HTML and BODY close tags defined. 
The Footer template is presented in the following code snippet (Footer.tmpl):

```
{{ define "Footer" }}
 </body>
  </html>
{{ end }}



```
The Menu template

The Menu template has the links defined for Home and Create Customer, as shown in the following code (Menu.tmpl):

```
{{ define "Menu" }}
<a href="/">Home</a> |<a href="/create">Create Customer</a>
{{ end }}

```
The Create template

The Create template consists of Header, Menu, and Footer templates. 
The form to create customer fields is found in the create template. 
This form is submitted to a web path—/insert, as shown in the following code snippet (Create.tmpl):

```
{{ define "Create" }}
 {{ template "Header" }}
{{ template "Menu" }}
  <br>
 <h1>Create Customer</h1>
 <br>
 <br>
 <form method="post" action="/insert">
 Customer Name: <input type="text" name="customername" placeholder="customername" autofocus/>
 <br>
 <br>
 SSN: <input type="text" name="ssn" placeholder="ssn"/>
 <br>
 <br>
 <input type="submit" value="Create Customer"/>
 </form>
{{ template "Footer" }}
{{ end }}


```
The Update template

The Update template consists of the Header, Menu, and Footer templates, as follows. The form to update 
customer fields is found in the Update template. This form is submitted to a web path, /alter (Update.tmpl)

```
{{ define "Update" }}
  {{ template "Header" }}
    {{ template "Menu" }}
<br>
<h1>Update Customer</h1>
    <br>
    <br>
  <form method="post" action="/alter">
    <input type="hidden" name="id" value="{{ .CustomerId }}" />
    Customer Name: <input type="text" name="customername" placeholder="customername" value="{{ .CustomerName }}" autofocus>
    <br>
    <br>
    SSN: <input type="text" name="ssn" value="{{ .SSN }}" placeholder="ssn"/>
    <br>
    <br>
    <input type="submit" value="Update Customer"/>
   </form>
{{ template "Footer" }}
{{ end }}


```

The View template

The View template consists of Header, Menu, and Footer templates. 
The form to view the customer fields is found in the View template, which is presented in code as follows (View.tmpl):

```
{{ define "View" }}
 {{ template "Header" }}
{{ template "Menu" }}
 <br>
 <h1>View Customer</h1>
 <br>
 <br>
<table border="1">
<tr>
<td>CustomerId</td>
<td>CustomerName</td>
<td>SSN</td>
<td>Update</td>
<td>Delete</td>
</tr>
{{ if . }}
 {{ range . }}
<tr>
<td>{{ .CustomerId }}</td>
<td>{{ .CustomerName }}</td>
<td>{{ .SSN }}</td>
<td><a href="/delete?id={{.CustomerId}}" onclick="return confirm('Are you sure you want to delete?');">Delete</a> </td>
<td><a href="/update?id={{.CustomerId}}">Update</a> </td>
</tr>
{{ end }}
 {{ end }}
</table>
{{ template "Footer" }}
{{ end }}
```
Run the following commands:

```
go run crm_app.go crm_database_operations.go

```

open loaclhost 8080 port on  browser 
