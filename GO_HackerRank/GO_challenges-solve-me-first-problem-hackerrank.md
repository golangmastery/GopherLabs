
# Problem
[HackerRank](https://www.hackerrank.com/challenges/solve-me-first/problem)

Complete the function solveMeFirst to compute the sum of two integers.

# Function prototype:
```
int solveMeFirst(int a, int b);
```

where,
- a is the first integer input.
- b is the second integer input
# Return values
sum of the above two integers

# Sample Input:
```
a = 2
b = 3
```
# Sample Output:
Explanation
The sum of the two integers ```a ```and ```b ```is computed as:``` 2 + 3 = 5```


# Solution:
```
package main
import "fmt"

func solveMeFirst(a uint32,b uint32) uint32{
  // Hint: Type return (a+b) below

  return a + b
}

func main() {
    var a, b, res uint32
    fmt.Scanf("%v\n%v", &a,&b)
    res = solveMeFirst(a,b)
    fmt.Println(res)
}
```




