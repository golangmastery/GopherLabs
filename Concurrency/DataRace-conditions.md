## Data Races and Race Conditions

One of the reasons why concurrency is hard to achieve is because of data races.

- Data Race 
   - A data race happens when processes have to access the same variable concurrently i.e. one process reads from a memory location while another 
   simultaneously writes to the exact same memory location.
   
   
```
package main
import "fmt"
func main() {
    number := 0;
    go func(){
      number++ //reading and modifying the value of 'number'
    }()
    fmt.Println(number) //reading the value of 'number'
}

```
- We increment the value of the variable number i.e. we first access the value, add 1 to it and then write the new value back to the memory. 
number++ takes place using an anonymous go routine. In the next step, we read the value of number and print it onto the console. However, the output of the 
code above turns out to be 0 because the main routine finishes itself before the goroutine has a chance to execute itself completely. We’ll explore more this in 
another gopherlabs track. The point to note in the above example is that number++ and fmt.Println(number) are participating in a data race as number++ is reading 
from and writing to the same memory location that `fmt.Println(number)` is reading from. This will get us in trouble if these operations execute at the same time 
which is a possibility when it comes to executing code with goroutines as they are concurrent operations.

![](https://raw.githubusercontent.com/sangam14/GopherLabs/master/img/datarace.png)

- While writing concurrent code, you need to be careful about data races and avoid the temptation to think sequentially. Instead, keep in mind all possible 
timings of your concurrent operations while designing your solution. This is because some data races are benign whereas some lead to race conditions.


## Race Condition 

A race condition is a flaw in a program regarding the timing/ordering of operations which disrupts the logic of the program and leads to erroneous results.

```
package main
import "fmt"
func deposit(balance *int,amount int){
    *balance += amount //add amount to balance
}
func withdraw(balance *int, amount int){
    *balance -= amount //subtract amount from balance
}
func main() {
    balance := 100
    go deposit(&balance,10) //depositing 10
    withdraw(&balance, 50) //withdrawing 50
    fmt.Println(balance)
}


```

In the code above, we have a balance of 100 . We first execute the deposit() operation using a goroutine and deposit 10 to our balance . Next, we withdraw 
50 from our balance which makes the final 60 . However, if you run the code, the final value of balance will come out to be 50 . This is as a result of a 
race condition which has compromised the correctness of the program due to an incorrect order of execution of operations.






