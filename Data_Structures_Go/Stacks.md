# Stack

>In computer science, `Stack` is an abstract data type that serves as a collection of similar elements. 

A stack has 2 basic operations - <br>
-  **Push** - Adds an element to the collection. <br>
-  **Pop** - Removes the recently added/pushed element to the collection. <br>

The order in which we remove the elements of the stack resembles a principle called as **LIFO (Last in First Out)** , i.e the element that we add last to the collection, gets removed first.<br>

In a stack, all insertions and deletions take place at one end of the collection, which is mostly referred as the **top** of the stack.<br>
A **Peek** operation may give access to the top element without any modifications in the stack. <br>
In a more simplified way, a stack can be imagined to be a pile(stack) of books. The book that you placed last on the pile, gets picked up the first.<br>

**Stack Overflow:** If the stack is full, and does not contain enough space to accept an element, the condition is called as Stack Overflow, and the stack is considered to be in an **overflow state**.<br>
<br>
**Stack underflow:** If the stack is empty, and an operation tries to remove an element from it, the condition is called Stack underflow, and the stack is considered to be in **underflow state**.

### Defining the structure of elements in the stack

```
type StackElement struct {
	name string
}
```

A `StackElement` is of type struct, which consists of an item called `name`, which is of a `string` data type. We will use elements of type `StackElement` in our collection.

### Defining the stack

```
type Stack struct {
    StackElements []*StackElement
    size int
}
```

The Stack consists of a list called `StackElements`, which is composed of the type `StackElement`. It can be resized as per the needs.

### Push operation

```
func (s *Stack) Push(el *StackElement) {
    s.StackElements = append(s.StackElements[:s.size], el)
    s.size++
}
```

`Push` operation adds an element to the top of stack. Here, we have appended the element `el` at the end, and then incremented the size of the stack.

### Pop operation

```
func (s *Stack) Pop() *StackElement {
    if s.size == 0 {
        // To prevent Stack underflow
        return nil
    }
    s.size--
    return s.StackElement[s.size]
}
```

`Pop` operation removes en element from the top of stack. <br>
To prevent the stack underflow condition, we first check if the stack is empty, if it is, then we just return `nil`.<br>
If the stack is not empty, we decrement the size of the stack and return the element that got removed.<br>

### Peek operation

```
func (s *Stack) Peek() *StackElement {
    return s.StackElements[s.size-1]
}
```
`Peek` operation returns the topmost element of the stack.

### Initialising the stack

```
func InitStack() *Stack {
    return &Stack{}
}
```
This function returns a new stack.

### Displaying the stack

```
func (s *Stack) display() *StackElement {

	for s.size > 0 {
		fmt.Print(s.Peek())
		s.Pop() // Pop
	}
	return nil

}
```

To print the stack elements, we print the top element, pop it, and then again repeat the process till the stack becomes empty.

### Main method

Now, we can use all these methods in our `main()` method to see how all of it functions together.

```

package main

import (
	"fmt"
)

type StackElement struct {
	name string
}

type Stack struct {
	StackElements []*StackElement
	size          int
}

func NewStack() *Stack {
	return &Stack{}
}

func (s *Stack) Push(el *StackElement) {
	s.StackElements = append(s.StackElements[:s.size], el)
	s.size++
}

func (s *Stack) Pop() *StackElement {
	if s.size == 0 {
		// To prevent Stack underflow
		return nil
	}
	s.size--
	return s.StackElements[s.size]
}

func (s *Stack) Peek() *StackElement {

	return s.StackElements[s.size-1]
}

func (s *Stack) display() *StackElement {

	for s.size > 0 {
		fmt.Print(s.Peek(), ", ")
		s.Pop()
	}
	return nil

}

func main() {
	s := NewStack()
	s.Push(&StackElement{"Ross"})
	s.Push(&StackElement{"Monica"})
	s.Push(&StackElement{"Chandler"})
	s.Push(&StackElement{"Joey"})
	s.Push(&StackElement{"Phoebe"})
	s.Push(&StackElement{"Rachel"})
	fmt.Println("The element at the top is ", s.Peek())
	fmt.Println("The elements in the stack from top to bottom are ")
	s.display()
}
```
- [Go Playground](https://play.golang.org/p/UrX8KhVSqok)

 The above program gives us the following output :
 ```
The element at the top is  &{Rachel}
The elements in the stack from top to bottom are 
&{Rachel}, &{Phoebe}, &{Joey}, &{Chandler}, &{Monica}, &{Ross}, 
 ```
