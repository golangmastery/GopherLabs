# Database Operations


# The GetCustomer method

The GetCustomer method retrieves the Customer data from the database.
To start with, thecreate database operation is shown in the following example. 
Customer is the table with the Customerid, CustomerName, and SSN attributes. The GetConnection methodreturns the 
database connection, which is used to query the database. The query then returns the rows from the database table. 
In the following code, database operations are explained in detail (database_operations.go):

```

package main

// importing fmt,database/sql, net/http, text/template package
import (
    "fmt"
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

// Customer Class
type Customer struct {
    CustomerId int
    CustomerName string
    SSN string
}
// GetConnection method which returns sql.DB
func GetConnection() (database *sql.DB) {
    databaseDriver := "mysql"
    databaseUser := "newuser"
    databasePass := "newuser"
    databaseName := "crm"
    database, error := sql.Open(databaseDriver, databaseUser+":"+databasePass+"@/"+databaseName)
    if error != nil {
        panic(error.Error())
    }
    return database
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

//main method
func main() {

     var customers []Customer
    customers = GetCustomers()
    fmt.Println("Customers",customers)

}

```
output : 
```
go run database_operations.go
```
Let's take a look at the InsertCustomer method in the next section.

# The InsertCustomer method

The INSERT operation is as follows. The InsertCustomer method takes the Customerparameter and creates a prepared 
statement for the INSERT statement. The statement is used to execute the insertion of customer rows into the table, 
as shown in the following snippet:

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
Let's take a look at the variadic functions in the next section.
