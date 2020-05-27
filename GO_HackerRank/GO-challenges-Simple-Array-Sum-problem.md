
# Problem
[HackerRank](https://www.hackerrank.com/challenges/simple-array-sum/problem)

Given an array of integers, find the sum of its elements.
For example, if the array``` ar=[1,2,3],1+2+3=6``` , so return``` 6```.

# Function Description
Complete the simpleArraySum function in the editor below. It must return the sum of the array elements as an integer.
simpleArraySum has the following parameter(s): <br>
ar: an array of integers 
where,
- a is the first integer input.
- b is the second integer input

# Input Format :

The first line contains an integer,```n``` , denoting the size of the array. 
The second line contains ```n ``` space-separated integers representing the array's elements.

# Constraints:
```0 < n,a[i]<= 1000```
# Sample Input:

```
6
1 2 3 4 10 11
```
# Sample Output:
```
31
```
# Explanation
We print the sum of the array's elements: ``` 1 + 2 + 3 + 4 + 10 + 11 = 31 .```


# Solution:
```
package main
import "fmt"

func main() {
    var n, currentNumber, sum int
    fmt.Scan(&n)
    for i:=0; i<n; i++ {
        fmt.Scan(&currentNumber)
        sum += currentNumber
    }
    fmt.Print(sum)
}
```






