# Resolving the user home directory

- It could be beneficial for the program to know the user's home directory, for example, in case you need to store a custom user configuration or any other data related to the user. 
This recipe will describe how you can find out the current user's home directory.

## Create the home.go file with the following content:
```
        package main

        import (
          "fmt"
          "log"
          "os/user"
        )

        func main() {
          usr, err := user.Current()
          if err != nil {
            log.Fatal(err)
          }
          fmt.Println("The user home directory: " + usr.HomeDir)
        }


```
output
```sangam:golang-daily sangam$ go run home.go 
The user home directory: /Users/sangam
sangam:golang-daily sangam$ 

```
## How it works...

- The os/user package contains the  Current function, which provides the os.User type pointer. The User contains the HomeDir property, which contains the path of the current user's home directory. 
