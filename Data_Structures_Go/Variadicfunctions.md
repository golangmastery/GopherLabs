# Variadic functions

- A function in which we pass an infinite number of arguments, instead of passing them one at a time, is called a variadic function. The type of the final parameter is preceded by an ellipsis (...), while declaring a variadic function; this shows us that the function might be called with any number of arguments of this type.

- Variadic functions can be invoked with a variable number of parameters. ` fmt.Println `is a common variadic function, as follows:

```

//main method
func main() {
var customers []Customer
customers = GetCustomers()
fmt.Println("Before Insert",customers)
var customer Customer
customer.CustomerName = "Arnie Smith"
customer.SSN = "2386343"
InsertCustomer(customer)
customers = GetCustomers()
fmt.Println("After Insert",customers)
    }
    
 ```
 ```
 go run database_operations.go
 ```
 
Let's start the update operation in the next section. 

## The update operation

The update operation is as follows. The UpdateCustomer method takes the Customerparameter and creates a prepared statement for the UPDATE statement.
The statement is used to update a customer row in the table:

```

// Update Customer method with parameter customer
func UpdateCustomer(customer Customer){
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
// main method
func main() {
var customers []Customer
customers = GetCustomers()
fmt.Println("Before Update",customers)
var customer Customer
customer.CustomerName = "George Thompson"
customer.SSN = "23233432"
customer.CustomerId = 5
UpdateCustomer(customer)
customers = GetCustomers()
fmt.Println("After Update",customers)
}


```

Let's take a look at the delete operation in the next section.

## The delete operation

Thedelete operation is as follows. The DeleteCustomer method takes the Customer parameter and creates a prepared statement for the DELETE statement. 
The statement is used to execute the deletion of a customer row in the table:

```

// Delete Customer method with parameter customer
func deleteCustomer(customer Customer){
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
// main method
func main() {
var customers []Customer
customers = GetCustomers()
fmt.Println("Before Delete",customers)
var customer Customer
customer.CustomerName = "sangam"
customer.SSN = "23233432"
customer.CustomerId = 5
deleteCustomer(customer)
customers = GetCustomers()
fmt.Println("After Delete",customers)
}


```



