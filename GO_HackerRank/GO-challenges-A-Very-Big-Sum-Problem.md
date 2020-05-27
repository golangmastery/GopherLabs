
# Problem
[HackerRank](https://www.hackerrank.com/challenges/a-very-big-sum/problem)

Calculate and print the sum of the elements in an array, keeping in mind that some of those integers may be quite large.

# Function Description
Complete the aVeryBigSum function in the editor below. It must return the sum of all array elements.

aVeryBigSum has the following parameter(s):

ar: an array of integers .

# Input Format
The first line of the input consists of an  N integer . 
The next line contains N space-separated integers contained in the array.

# Output Format
Print the integer sum of the elements in the array.

Constraints
```
1 <= n <= 10
0 <= ar[i] <= 10^10
```

# Sample Input :
```
5
1000000001 1000000002 1000000003 1000000004 1000000005
```

# Sample Output :
```
5000000015
```

# Explanation :

In this example:

The range of the 32-bit integer is ```(-2^31)``` to ```(-2^31 - 1 )``` or ```[-2147483648 , 2147483647]```.
When we add several integer values, the resulting sum might exceed the above range.
You might need to use long long int in C/C++ or long data type in Java to store such sums.

# Golang tips 

```
package main
 
import "fmt"
 
func main(){
    var n1 uint8 // Unsigned 8-bit integers (0 to 255)
    n1 = 200
    fmt.Println(n1)
     
    var n2 uint16 // Unsigned 16-bit integers (0 to 65535)
    n2 = 54200
    fmt.Println(n2)
     
    var n3 uint32 // Unsigned 32-bit integers (0 to 4294967295)
    n3 = 98765214
    fmt.Println(n3)
     
    var n4 uint64 // Unsigned 64-bit integers (0 to 18446744073709551615)
    n4 = 1844674073709551615
    fmt.Println(n4)
     
    var n5 int8 //Signed 8-bit integers (-128 to 127)
    n5 = -52
    fmt.Println(n5)
    fmt.Println(n5*-1)
     
    var n6 int16 // Signed 16-bit integers (-32768 to 32767)
    n6 = -32552
    fmt.Println(n6)
    fmt.Println(n6*-1)
     
    var n7 int32 // Signed 32-bit integers (-2147483648 to 2147483647)
    n7 = -98658754
    fmt.Println(n7)
    fmt.Println(n7*-1)
     
    var n8 int64 // Signed 64-bit integers (-9223372036854775808 to 9223372036854775807)
    n8 = -92211111111111111
    fmt.Println(n8)
    fmt.Println(n8*-1)
}
``` 

# Solution 
```
package main

import (
    "fmt"
    "io"
    "os"
)

var stdin io.Reader = os.Stdin
var stdout io.Writer = os.Stdout

func main() {
    var n int
    fmt.Fscanf(stdin, "%d", &n)
    sum := uint64(0)
    for i := 0; i < n; i++ {
        var x uint64
        fmt.Fscanf(stdin, "%d", &x)
        sum += x
    }
    fmt.Fprintln(stdout, sum)
}


```
